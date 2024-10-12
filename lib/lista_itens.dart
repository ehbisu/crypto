import 'package:flutter/material.dart';

class ListaItensPage extends StatelessWidget {
  final String nome;

  const ListaItensPage({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    final List<String> itens =
        List.generate(20, (index) => "Item ${index + 1}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo(a), $nome'),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itens[index]),
            onTap: () {
              // Ao clicar no item, exibe o AlertDialog
              _showAlertDialog(context, index + 1);
            },
          );
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context, int itemIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('Você clicou no item [$itemIndex].'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o AlertDialog
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o AlertDialog
              },
              child: const Text('Não'),
            ),
          ],
        );
      },
    );
  }
}