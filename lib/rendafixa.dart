import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'crypto.dart'; // Import the necessary pages
import 'educacao.dart';
import '../local_storage_helper.dart'; // Import LocalStorageHelper
import 'dart:convert';

class RendaFixaPage extends StatefulWidget {
  const RendaFixaPage({Key? key}) : super(key: key);

  @override
  _RendaFixaPageState createState() => _RendaFixaPageState();
}

class _RendaFixaPageState extends State<RendaFixaPage> {
  // Controladores dos campos de texto
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _vencimentoController = TextEditingController();

  // Lista de aplicações em renda fixa
  List<Map<String, dynamic>> investments = [];

  // Tipo selecionado e opções de tipos de aplicação
  String _selectedTipo = 'CDB';
  final List<String> _tipos = ['CDB', 'LCI', 'LCA', 'Tesouro Direto'];

  int _selectedIndex = 0; // Índice do BottomNavigationBar

  double _userSaldo = 0.0;
  String _userName = "User";
  final LocalStorageHelper _storageHelper = LocalStorageHelper();

  // Chave para armazenar as aplicações de renda fixa
  static const String _rendaFixaKey = 'renda_fixa_investments';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadInvestments();
  }

  // Carrega dados do usuário (saldo, nome)
  Future<void> _loadUserData() async {
    double saldo = await _storageHelper.getUserSaldo();
    Map<String, dynamic>? userData = await _storageHelper.getUserData();
    String userName = "User";
    if (userData != null && userData['usuario'] != null) {
      userName = userData['usuario'];
    }

    setState(() {
      _userSaldo = saldo;
      _userName = userName;
    });
  }

  // Carrega as aplicações de renda fixa do local storage
  Future<void> _loadInvestments() async {
    final prefs = await SharedPreferences.getInstance();
    String? investmentsJson = prefs.getString(_rendaFixaKey);
    if (investmentsJson != null) {
      List<dynamic> storedInvestments = json.decode(investmentsJson);
      setState(() {
        investments = storedInvestments.cast<Map<String, dynamic>>();
      });
    }
  }

  // Salva as aplicações de renda fixa no local storage
  Future<void> _saveInvestments() async {
    final prefs = await SharedPreferences.getInstance();
    String investmentsJson = json.encode(investments);
    await prefs.setString(_rendaFixaKey, investmentsJson);
  }

  // Adiciona uma nova aplicação
  // Ao adicionar, deduz do saldo do usuário imediatamente
  void _addInvestment() async {
    if (_valorController.text.isNotEmpty && _vencimentoController.text.isNotEmpty) {
      double? valor = double.tryParse(_valorController.text.replaceAll(',', '.'));
      int? vencimentoDias = int.tryParse(_vencimentoController.text);
      if (valor == null || vencimentoDias == null) {
        return; 
      }

      // Verifica se o usuário tem saldo suficiente
      if (valor > _userSaldo) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saldo insuficiente!')),
        );
        return;
      }

      // Deduzir saldo
      double novoSaldo = _userSaldo - valor;
      await _storageHelper.saveUserSaldo(novoSaldo);

      // Atualiza estado do saldo
      setState(() {
        _userSaldo = novoSaldo;
      });

      Map<String, dynamic> newInvestment = {
        'valor': valor,
        'tipo': _selectedTipo,
        'vencimento': vencimentoDias,
        'data_compra': DateTime.now().toIso8601String()
      };

      setState(() {
        investments.add(newInvestment);
      });

      _valorController.clear();
      _vencimentoController.clear();

      _saveInvestments();
    }
  }

  // Retorna a taxa anual de acordo com o tipo
  double _getAnnualRate(String tipo) {
    switch (tipo) {
      case 'CDB':
        return 0.10; // 10% ao ano (exemplo)
      case 'LCI':
        return 0.09; // 9% ao ano
      case 'LCA':
        return 0.095; // 9.5% ao ano
      case 'Tesouro Direto':
        return 0.08; // 8% ao ano
      default:
        return 0.08; 
    }
  }

  int _calculateHeldDays(String dataCompra) {
    DateTime buyDate = DateTime.parse(dataCompra);
    DateTime now = DateTime.now();
    return now.difference(buyDate).inDays;
  }

  // Calcula tanto o juro atual quanto o juro final no vencimento
  Map<String, double> _calculateValues(double valor, String tipo, int vencimentoDias, String dataCompra) {
    double annualRate = _getAnnualRate(tipo);
    int heldDays = _calculateHeldDays(dataCompra);

    // Juros no vencimento
    double fractionOfYearAtEnd = vencimentoDias / 365.0;
    double finalInterest = valor * annualRate * fractionOfYearAtEnd;
    double finalValue = valor + finalInterest;

    // Juros atuais (baseado nos dias corridos)
    double fractionOfYearHeld = heldDays / 365.0;
    double interestHeld = valor * annualRate * fractionOfYearHeld;
    double currentValue = valor + interestHeld;

    return {
      'interestHeld': interestHeld,
      'currentValue': currentValue,
      'finalInterest': finalInterest,
      'finalValue': finalValue,
      'heldDays': heldDays.toDouble(),
    };
  }

  // Função para vender o investimento
  // Ao vender, adicionamos o valor atual ao saldo do usuário e removemos o investimento
  void _sellInvestment(int index) async {
    final investment = investments[index];
    double valor = investment['valor'] ?? 0.0;
    String tipo = investment['tipo'] ?? '';
    int vencimento = investment['vencimento'] ?? 0;
    String dataCompra = investment['data_compra'];

    final results = _calculateValues(valor, tipo, vencimento, dataCompra);
    double currentValue = results['currentValue'] ?? valor;

    // Atualiza saldo
    double novoSaldo = _userSaldo + currentValue;
    await _storageHelper.saveUserSaldo(novoSaldo);

    setState(() {
      _userSaldo = novoSaldo;
      investments.removeAt(index);
    });

    _saveInvestments();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Você vendeu por ${currentValue.toStringAsFixed(2)} R\$!'))
    );
  }

  // Ao clicar nos ícones da barra inferior
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CryptoPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EducacaoPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C33),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 20),
          _buildFormSection(),
          const SizedBox(height: 20),
          _buildInvestmentsList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 24, 38, 64),
        iconSize: 30.0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'EBISU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    const TextSpan(
                      text: 'Saldo: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: _userSaldo.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/icon.png'),
                radius: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 34, 51, 82),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFCCCC99),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Renda Fixa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTextInputField('Valor da aplicação', 'R\$ 0.00', _valorController),
            const SizedBox(height: 10),
            _buildDropdownInput('Tipo da aplicação', _selectedTipo, _tipos),
            const SizedBox(height: 10),
            _buildTextInputField('Vencimento (dias)', 'Ex: 30', _vencimentoController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addInvestment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  'INVESTIR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownInput(
      String label, String selectedValue, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedValue,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: const Color(0xFF0F1C33),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.02),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white54),
            ),
          ),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedTipo = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextInputField(
      String label, String placeholder, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentsList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: investments.length,
          itemBuilder: (context, index) {
            final investment = investments[index];
            double valor = investment['valor'] ?? 0.0;
            String tipo = investment['tipo'] ?? '';
            int vencimento = investment['vencimento'] ?? 0;
            String dataCompra = investment['data_compra'];
            return _buildInvestmentItem(valor, tipo, vencimento, dataCompra, index);
          },
        ),
      ),
    );
  }

  Widget _buildInvestmentItem(double valor, String tipo, int vencimento, String dataCompra, int index) {
    final results = _calculateValues(valor, tipo, vencimento, dataCompra);

    double interestHeld = results['interestHeld'] ?? 0.0;  // juros atual
    double currentValue = results['currentValue'] ?? valor;  
    double finalInterest = results['finalInterest'] ?? 0.0; // juros no vencimento
    double finalValue = results['finalValue'] ?? valor;
    int heldDays = results['heldDays']?.toInt() ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 51, 82),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCCCC99),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Exibir valor, tipo, vencimento, dias segurando, juros atual e juros no vencimento
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor Inicial: ${valor.toStringAsFixed(2)} R\$',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Tipo: $tipo',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'Vencimento: $vencimento dias',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'Dias hold: $heldDays',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Juros Est. Atual: ${interestHeld.toStringAsFixed(2)} R\$',
                style: const TextStyle(color: Colors.yellowAccent, fontSize: 14),
              ),
              Text(
                'Valor Atual: ${currentValue.toStringAsFixed(2)} R\$',
                style: const TextStyle(color: Colors.yellowAccent, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Juros Est. no Vencimento: ${finalInterest.toStringAsFixed(2)} R\$',
                style: const TextStyle(color: Colors.yellowAccent, fontSize: 14),
              ),
              Text(
                'Valor Final no Vencimento: ${finalValue.toStringAsFixed(2)} R\$',
                style: const TextStyle(color: Colors.yellowAccent, fontSize: 14),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.attach_money, color: Colors.white),
            onPressed: () {
              _sellInvestment(index);
            },
            tooltip: 'Vender',
          ),
        ],
      ),
    );
  }
}
