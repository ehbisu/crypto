import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Função para fazer login com username e senha
  Future<String?> login(String username, String password) async {
    try {
      // Calcula o hash SHA256 da senha
      String passwordHash = _generateHash(password);

      // Busca o usuário pelo campo 'usuario'
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('usuario', isEqualTo: username)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        Map<String, dynamic> userData =
            query.docs.first.data() as Map<String, dynamic>;

        // Verifica se o hash da senha corresponde
        if (userData['password'] == passwordHash) {
          print("Login bem-sucedido! UID: ${query.docs.first.id}");
          return query.docs.first.id; // Retorna o ID do documento como userId
        } else {
          throw Exception("Senha incorreta.");
        }
      } else {
        throw Exception("Usuário não encontrado.");
      }
    } catch (e) {
      print("Erro no login: $e");
      throw e;
    }
  }

  /// Função para registrar um novo usuário
  Future<void> register(String username, String password) async {
    try {
      String passwordHash = _generateHash(password);

      // Verifica se o username já existe
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('usuario', isEqualTo: username)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        // Salva o novo usuário no Firestore
        await _firestore.collection('users').add({
          'usuario': username,
          'password': passwordHash,
          'saldo': 0.0,
        });
        print("Usuário registrado com sucesso!");
      } else {
        throw Exception("Username já existe.");
      }
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      throw e;
    }
  }

  /// Função auxiliar para gerar hash SHA256
  String _generateHash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
