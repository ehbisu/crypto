import 'package:flutter/material.dart';
import '../firebase_helper.dart';
import '../hash_utils.dart'; // Utilidade de hash

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Indica se o login está em andamento
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  void _loginUser() async {
    String usuario = _usuarioController.text.trim();
    String password = _passwordController.text.trim();

    print('Tentando fazer login com Usuário: $usuario e Senha: $password');

    if (usuario.isEmpty || password.isEmpty) {
      _showSnackBar('Por favor, preencha todos os campos.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Recuperar dados do usuário do Firebase
      Map<String, dynamic>? userData = await _firebaseHelper.getUserData(usuario);
      print('Dados do usuário recuperados: $userData');

      if (userData == null) {
        _showSnackBar('Usuário não encontrado.');
      } else {
        // Hashear a senha inserida
        String hashedPassword = HashUtils.hashPassword(password);
        print('Senha hasheada: $hashedPassword');
        print('Senha armazenada: ${userData['password']}');

        if (hashedPassword == userData['password']) {
          // Login bem-sucedido
          _showSnackBar('Login bem-sucedido!', isError: false);
          Navigator.pushReplacementNamed(context, '/crypto');
        } else {
          _showSnackBar('Senha incorreta.');
        }
      }
    } catch (e) {
      _showSnackBar('Erro ao fazer login: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _forgotPasswordUsuarioController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C2C44),
          title: const Text(
            'Recuperar Senha',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Por favor, insira seu usuário para recuperar sua senha.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _forgotPasswordUsuarioController,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCAC53),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                String usuario = _forgotPasswordUsuarioController.text.trim();
                if (usuario.isNotEmpty && _validateUsuario(usuario)) {
                  // Verifica se o usuário existe no Firebase
                  Map<String, dynamic>? userData =
                      await _firebaseHelper.getUserData(usuario);
                  if (userData != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Instruções de recuperação enviadas!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuário não encontrado.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira um usuário válido.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateUsuario(String usuario) {
    return usuario.length >= 4;
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF487187),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                      TextField(
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Color(0xFF0B2A45),
                        ),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      PasswordField(controller: _passwordController),
                      const SizedBox(height: 10),

                      HoverableText(
                        text: 'Esqueceu sua senha?',
                        onTap: () {
                          _showForgotPasswordDialog(context);
                        },
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: _isLoading ? null : _loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCCAC53),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )
                            : const Text('Entrar',
                                style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cadastro');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C2C44),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          side: const BorderSide(color: Colors.white),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Não tem uma conta? Registre-se',
                            style: TextStyle(color: Colors.white)),
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

// Outros widgets como PasswordField e HoverableText permanecem inalterados.


// Widget de campo de senha personalizado que recebe o controller por parâmetro
class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({required this.controller, Key? key}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Senha',
        labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: _toggleVisibility,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: const Color(0xFF0B2A45),
      ),
      obscureText: _obscureText,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}

// Texto "hoverable"
class HoverableText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverableText({
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _HoverableTextState createState() => _HoverableTextState();
}

class _HoverableTextState extends State<HoverableText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovering ? Colors.yellow.shade200 : Colors.white70,
            fontSize: 14,
            decoration: TextDecoration.none,
            fontWeight: _isHovering ? FontWeight.w600 : FontWeight.normal,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
