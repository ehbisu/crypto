import 'package:flutter/material.dart';
import 'crypto.dart'; // Importa o arquivo crypto.dart
import 'cadastro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _isObscured = true;
  double _fontSize = 16;

  // Função para exibir o AlertDialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dados inválidos'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Função para verificar login
  void _login() {
    final email = _emailController.text;
    final senha = _senhaController.text;

    if (email == 'eumesmo@gmail.com' && senha == '12345') {
      // Redirecionar para a página CryptoPage se o login for bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CryptoPage(),
        ),
      );
    } else {
      // Mostrar AlertDialog com mensagem de erro
      _showErrorDialog('Usuário e/ou senha incorreto(a)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(fontSize: _fontSize),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: _fontSize),
                ),
                const SizedBox(height: 20),

                // Campo de senha com exibição/ocultação
                TextField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: _fontSize),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscured,
                  style: TextStyle(fontSize: _fontSize),
                ),
                const SizedBox(height: 20),

                // Controle de tamanho da fonte
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
                const SizedBox(height: 20),

                // Botão de login
                ElevatedButton(
                  onPressed: _login, // Chama a função de login
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 91, 44, 122),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Sign-in'),
                ),
                const SizedBox(height: 20),

                // Botão para cadastro
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroPage(),
                      ),
                    );
                  },
                  child: const Text('Don’t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
