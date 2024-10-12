import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Controladores de texto para os campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();

  // Variáveis para armazenar o estado
  String? _generoSelecionado = 'Masculino';
  bool _notificacaoEmail = false;
  bool _notificacaoCelular = false;
  bool _isObscured = true;

  // Tamanho da fonte controlado pelo Slider
  double _fontSize = 16;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  // Função para abrir o calendário
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dataNascimentoController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 91, 44, 122),
        title: const Text('Cadastro'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior (login)
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      // Nome
                      TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          counterText: '${_nomeController.text.length}/20',
                          labelStyle: TextStyle(fontSize: _fontSize),
                        ),
                        style: TextStyle(fontSize: _fontSize),
                        maxLength: 20,
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),

                      // Data de nascimento com showDatePicker
                      TextField(
                        controller: _dataNascimentoController,
                        decoration: InputDecoration(
                          labelText: 'Birth Date',
                          labelStyle: TextStyle(fontSize: _fontSize),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        style: TextStyle(fontSize: _fontSize),
                        readOnly:
                            true, // Evita que o usuário digite manualmente
                        onTap: () {
                          _selectDate(context);
                        },
                      ),

                      // E-mail
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          counterText: '${_emailController.text.length}/50',
                          labelStyle: TextStyle(fontSize: _fontSize),
                        ),
                        style: TextStyle(fontSize: _fontSize),
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 50,
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),

                      // Telefone
                      TextField(
                        controller: _telefoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          counterText: '${_telefoneController.text.length}/11',
                          labelStyle: TextStyle(fontSize: _fontSize),
                        ),
                        style: TextStyle(fontSize: _fontSize),
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),

                      // Senha com exibição/ocultação
                      TextField(
                        controller: _senhaController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          counterText: '${_senhaController.text.length}/20',
                          labelStyle: TextStyle(fontSize: _fontSize),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(fontSize: _fontSize),
                        obscureText: _isObscured,
                        maxLength: 20,
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 10),
                      Text('Gender:', style: TextStyle(fontSize: _fontSize)),

                      // Gênero com RadioButton
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Masculine',
                                  groupValue: _generoSelecionado,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _generoSelecionado = value;
                                    });
                                  },
                                ),
                                Text('Masculine',
                                    style: TextStyle(fontSize: _fontSize)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Feminine',
                                  groupValue: _generoSelecionado,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _generoSelecionado = value;
                                    });
                                  },
                                ),
                                Text('Feminine',
                                    style: TextStyle(fontSize: _fontSize)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Notificações com Switch
                      Text('Notifications:',
                          style: TextStyle(fontSize: _fontSize)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('E-mail', style: TextStyle(fontSize: _fontSize)),
                          Switch(
                            value: _notificacaoEmail,
                            onChanged: (bool newValue) {
                              setState(() {
                                _notificacaoEmail = newValue;
                              });
                            },
                          ),
                          Text('Cellphone',
                              style: TextStyle(fontSize: _fontSize)),
                          Switch(
                            value: _notificacaoCelular,
                            onChanged: (bool newValue) {
                              setState(() {
                                _notificacaoCelular = newValue;
                              });
                            },
                          ),
                        ],
                      ),

                      // Slider para controlar o tamanho da fonte
                      const SizedBox(height: 20),
                      Text('Font Size: ${_fontSize.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: _fontSize)),
                      Slider(
                        value: _fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 6,
                        label: _fontSize.toStringAsFixed(0),
                        onChanged: (double newValue) {
                          setState(() {
                            _fontSize = newValue;
                          });
                        },
                      ),

                      // Botão cadastrar
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 91, 44, 122),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}