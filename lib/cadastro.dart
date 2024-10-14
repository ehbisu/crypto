import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF487187), // Background color

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder (adjust the size and path as needed)
              Image.asset('assets/images/logo.png', height: 150), // Bigger logo

              const SizedBox(height: 40), // Space between logo and form

              // Main register section inside a container with a different background color
              Container(
                padding: const EdgeInsets.all(20.0),
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2C44),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Name field
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: const TextStyle(
                            fontSize: 16, color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0B2A45),
                      ),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Email field
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: const TextStyle(
                            fontSize: 16, color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0B2A45),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Password field with show/hide option
                    PasswordField(),
                    const SizedBox(height: 20),

                    // Register button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCAC53),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        minimumSize: const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text('Registrar',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), // Space between form and any additional content

              // Go back to login button with styled "Entrar"
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to login
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Já tem uma conta? ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Entrar',
                        style: TextStyle(
                          color: Colors.yellow.shade200, // Softer yellow
                          decoration: TextDecoration.none, // Removed underline
                          fontWeight: FontWeight.w600, // Slightly bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Password Field Widget with Show/Hide functionality
class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

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
