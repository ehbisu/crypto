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
                        labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
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
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Password field with show/hide option
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(fontSize: 16, color: Colors.white),
                        suffixIcon: const Icon(Icons.visibility, color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0B2A45),
                      ),
                      obscureText: true,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Sign-in button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/crypto'); // Navigate to CryptoPage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCAC53), // Button color
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minimumSize: const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text('Sign-in', style: TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(height: 20), // Add space between buttons

                    // Register button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cadastro'); // Navigate to CadastroPage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2C44), // Match background
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: const BorderSide(color: Colors.white), // Add border for contrast
                        minimumSize: const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text('Don’t have an account? Register', style: TextStyle(color: Colors.white)),
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
}
