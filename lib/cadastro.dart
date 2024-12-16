import 'package:flutter/material.dart';
import '../firebase_helper.dart';
import '../hash_utils.dart'; // Importe a utilidade de hash

class CadastroPage extends StatelessWidget {
  CadastroPage({super.key});

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  void _registerUser(BuildContext context) async {
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    print('Tentando registrar usuário: $usuario');

    if (usuario.isNotEmpty && password.isNotEmpty) {
      if (!_validateUsuario(usuario)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira um usuário válido (mínimo 4 caracteres).')),
        );
        return;
      }

      String hashedPassword = HashUtils.hashPassword(password);

      try {
        // Verificar se o usuário já existe no Firestore
        Map<String, dynamic>? existingUser = await _firebaseHelper.getUserData(usuario);
        if (existingUser != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário já está em uso.')),
          );
          return;
        }

        // Salvar os dados do novo usuário no Firestore
        await _firebaseHelper.saveUserData(usuario, {
          'usuario': usuario,
          'password': hashedPassword,
          'saldo': 0.0, // Inicializar o saldo do usuário
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
        );

        // Redirecionar para a página de Login
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao registrar usuário: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
    }
  }

  /// Validação simples do nome de usuário
  bool _validateUsuario(String usuario) {
    return usuario.length >= 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF487187),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 150),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2C44),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Color(0xFF0B2A45),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Color(0xFF0B2A45),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _registerUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCCAC53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
