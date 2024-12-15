import 'package:flutter/material.dart';
import 'crypto.dart'; // Import the necessary pages
import 'educacao.dart';
import '../local_storage_helper.dart'; // Import LocalStorageHelper

class RendaFixaPage extends StatefulWidget {
  const RendaFixaPage({Key? key}) : super(key: key);

  @override
  _RendaFixaPageState createState() => _RendaFixaPageState();
}

class _RendaFixaPageState extends State<RendaFixaPage> {
  // List to store investments
  List<Map<String, String>> investments = [];

  // Controllers for form fields
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _vencimentoController = TextEditingController();

  // Predefined options for the application type
  String _selectedTipo = 'CDB'; // Default selected value
  final List<String> _tipos = ['CDB', 'LCI', 'LCA', 'Tesouro Direto'];

  int _selectedIndex = 0; // To track the selected bottom nav index

  double _userSaldo = 0.0;
  String _userName = "User";
  final LocalStorageHelper _storageHelper = LocalStorageHelper();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

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

  // Method to add a new investment
  void _addInvestment() {
    if (_valorController.text.isNotEmpty &&
        _vencimentoController.text.isNotEmpty) {
      setState(() {
        investments.add({
          'valor': _valorController.text,
          'tipo': _selectedTipo,
          'vencimento': _vencimentoController.text,
        });
      });

      _valorController.clear();
      _vencimentoController.clear();
    }
  }

  // BottomNavigationBar callback
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
              Text(
                _userName,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
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
            _buildTextInputField('Vencimento', 'Ex: 30 dias', _vencimentoController),
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
            return _buildInvestmentItem(
              investment['valor'] ?? '',
              investment['tipo'] ?? '',
              investment['vencimento'] ?? '',
            );
          },
        ),
      ),
    );
  }

  Widget _buildInvestmentItem(String valor, String tipo, String vencimento) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Valor: $valor R\$',
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
            ],
          ),
          const Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }
}
