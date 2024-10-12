import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bem-vindo à HomePage!',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}