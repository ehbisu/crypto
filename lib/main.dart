import 'package:flutter/material.dart';
import 'login.dart';
import 'crypto.dart';
import 'cadastro.dart';
// Importação de LocalStorageHelper não é necessária aqui a menos que seja usada diretamente no main

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Não é mais necessário inicializar o banco de dados
  // Todas as operações de armazenamento serão feitas via SharedPreferences

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
        '/cadastro': (context) => CadastroPage(),
        '/crypto': (context) => const CryptoPage(),
      },
    );
  }
}
