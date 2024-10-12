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
                        labelText: 'Name',
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
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

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

                    // Password field
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

                    // Register button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCAC53),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minimumSize: const Size.fromHeight(50), // Make button full-width
                      ),
                      child: const Text('Register', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), // Space between form and any additional content

              // Go back to login button (optional)
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to login
                },
                child: const Text(
                  'Already have an account? Sign in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
