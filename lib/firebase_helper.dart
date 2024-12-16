import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Salva o saldo do usuário
  Future<void> saveUserSaldo(String userId, double saldo) async {
    try {
      await _firestore.collection('users').doc(userId).update({'saldo': saldo});
      print('Saldo salvo no Firestore: $saldo');
    } catch (e) {
      print('Erro ao salvar saldo no Firestore: $e');
      throw e;
    }
  }

  /// Recupera o saldo do usuário
  Future<double> getUserSaldo(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return (doc.data() as Map<String, dynamic>)['saldo'] ?? 0.0;
      }
      return 0.0; // Saldo padrão
    } catch (e) {
      print('Erro ao recuperar saldo no Firestore: $e');
      throw e;
    }
  }

  /// Salva os dados do usuário
  Future<void> saveUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData);
      print('Dados do usuário salvos no Firestore: $userData');
    } catch (e) {
      print('Erro ao salvar dados do usuário no Firestore: $e');
      throw e;
    }
  }

  /// Recupera os dados do usuário
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        print('Dados do usuário recuperados: $userData');
        return userData;
      }
      print('Nenhum dado de usuário encontrado no Firestore.');
      return null;
    } catch (e) {
      print('Erro ao recuperar dados do Firestore: $e');
      throw e;
    }
  }

  /// Salva uma nova transação
  Future<void> addTransaction(String userId, Map<String, dynamic> transaction) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .add(transaction);
      print('Transação adicionada: $transaction');
    } catch (e) {
      print('Erro ao salvar transação no Firestore: $e');
      throw e;
    }
  }

  /// Recupera todas as transações
  Future<List<Map<String, dynamic>>> getTransactions(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .get();
      List<Map<String, dynamic>> transactions = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      print('Transações recuperadas: $transactions');
      return transactions;
    } catch (e) {
      print('Erro ao recuperar transações do Firestore: $e');
      throw e;
    }
  }

  /// Salva o portfólio do usuário (Map<String, double>)
  Future<void> saveUserPortfolio(String userId, Map<String, double> portfolio) async {
    try {
      await _firestore.collection('users').doc(userId).update({'portfolio': portfolio});
      print('Portfólio salvo no Firestore: $portfolio');
    } catch (e) {
      print('Erro ao salvar portfólio no Firestore: $e');
      throw e;
    }
  }

  /// Recupera o portfólio do usuário (Map<String, double>)
  Future<Map<String, double>?> getUserPortfolio(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic>? portfolio = (doc.data() as Map<String, dynamic>)['portfolio'];
        if (portfolio != null) {
          return portfolio.map((key, value) => MapEntry(key, value.toDouble()));
        }
      }
      print('Nenhum portfólio encontrado no Firestore.');
      return null;
    } catch (e) {
      print('Erro ao recuperar portfólio no Firestore: $e');
      throw e;
    }
  }

  /// Limpa todos os dados armazenados de um usuário
  Future<void> clearAll(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('Todos os dados do usuário foram removidos do Firestore.');
    } catch (e) {
      print('Erro ao limpar dados do Firestore: $e');
      throw e;
    }
  }
  /// Salva um novo investimento para o usuário
Future<void> addInvestment(String userId, Map<String, dynamic> investment) async {
  try {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('investments') // Sub-coleção para armazenar os investimentos
        .add(investment); // Adiciona um novo investimento
    print('Investimento adicionado: $investment');
  } catch (e) {
    print('Erro ao salvar investimento no Firestore: $e');
    throw e;
  }
}

/// Recupera todos os investimentos de um usuário
Future<List<Map<String, dynamic>>> getInvestments(String userId) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('investments') // Sub-coleção para os investimentos
        .get(); // Recupera todos os documentos na coleção

    // Mapeia os documentos para uma lista de Map<String, dynamic>
    List<Map<String, dynamic>> investments = querySnapshot.docs
        .map((doc) => {
              'id': doc.id, // Adiciona o ID do documento como referência
              ...doc.data() as Map<String, dynamic>, // Dados do investimento
            })
        .toList();

    print('Investimentos recuperados: $investments');
    return investments;
  } catch (e) {
    print('Erro ao recuperar investimentos do Firestore: $e');
    throw e;
  }
}

}
