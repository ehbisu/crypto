import 'package:flutter/material.dart';
import 'login.dart';
import 'crypto.dart';
import 'cadastro.dart';

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
        '/cadastro': (context) => const CadastroPage(),
        '/crypto': (context) => const CryptoPage(), 
      },
    );
  }
}
