import 'package:flutter/material.dart';
import 'login.dart';
import 'crypto.dart';
import 'cadastro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Importação de LocalStorageHelper não é necessária aqui a menos que seja usada diretamente no main

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
