import 'package:flutter/material.dart';
import 'login.dart';
import 'crypto.dart';
import 'cadastro.dart';
import 'package:crypto/about.dart';
import 'package:crypto/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ebisu',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/cadastro': (context) => const CadastroPage(),
        '/crypto': (context) => const CryptoPage(), 
      },
    );
  }
}
