import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF487187), // Set the background color

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder (adjust the size and path as needed)
              Image.asset('assets/images/logo.png', height: 150),

              const SizedBox(height: 40), // Space between logo and form

              // Main login section inside a container with a different background color
              Container(
                padding: const EdgeInsets.all(20.0),
                width: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2C44), // Secondary background color for the container
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
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
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Password field with show/hide option
                    PasswordField(),
                    const SizedBox(height: 10),

                    // "Esqueceu sua senha?" text with updated styling
                    HoverableText(
                      text: 'Esqueceu sua senha?',
                      onTap: () {
                        _showForgotPasswordDialog(context);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Sign-in button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/crypto'); // Navigate to CryptoPage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCAC53), // Button color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        minimumSize:
                            const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text('Entrar',
                          style: TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(height: 20), // Add space between buttons

                    // Register button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cadastro'); // Navigate to CadastroPage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF1C2C44), // Match background
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        side: const BorderSide(
                            color: Colors.white), // Add border for contrast
                        minimumSize:
                            const Size.fromHeight(50), // Make button full-width
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
    );
  }

  /// Function to display the Forgot Password dialog
  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

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
                'Por favor, insira seu e-mail para recuperar sua senha.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle:
                      TextStyle(fontSize: 14, color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
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
                Navigator.of(context).pop(); // Close the dialog
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
              onPressed: () {
                String email = _emailController.text.trim();
                if (email.isNotEmpty && _validateEmail(email)) {
                  // Handle password reset logic here
                  // For demonstration, we'll just print the email
                  print('Password reset requested for: $email');

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Instruções de recuperação enviadas!'),
                    ),
                  );

                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira um e-mail válido.'),
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

  /// Simple email validation
  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(
        r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
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

/// Custom Hoverable Text Widget
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
      cursor: SystemMouseCursors.click, // Change cursor to pointer
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
            color: _isHovering
                ? Colors.yellow.shade200 // Softer yellow on hover
                : Colors.white70, // Default color
            fontSize: 14,
            decoration: TextDecoration.none, // Remove underline
            fontWeight:
                _isHovering ? FontWeight.w600 : FontWeight.normal, // Slightly bold on hover
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
