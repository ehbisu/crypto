// lib/local_storage_helper.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static const String _saldoKey = 'user_saldo';
  static const String _userDataKey = 'user_data';
  static const String _transactionsKey = 'user_transactions';
  static const String _portfolioKey = 'user_portfolio'; // Chave para o portfólio do usuário

  /// Salva o saldo do usuário
  Future<void> saveUserSaldo(double saldo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_saldoKey, saldo);
    print('Saldo salvo: $saldo');
  }

  /// Recupera o saldo do usuário
  Future<double> getUserSaldo() async {
    final prefs = await SharedPreferences.getInstance();
    double saldo = prefs.getDouble(_saldoKey) ?? 0.0;
    print('Saldo recuperado: $saldo');
    return saldo;
  }

  /// Salva os dados do usuário como JSON
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = json.encode(userData);
    await prefs.setString(_userDataKey, userDataString);
    print('Dados do usuário salvos: $userDataString');
  }

  /// Recupera os dados do usuário
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString) as Map<String, dynamic>;
      print('Dados do usuário recuperados: $userData');
      return userData;
    }
    print('Nenhum dado de usuário encontrado.');
    return null;
  }

  /// Salva uma nova transação
  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> transactions = prefs.getStringList(_transactionsKey) ?? <String>[];

    transactions.add(json.encode(transaction));
    await prefs.setStringList(_transactionsKey, transactions);
    print('Transação adicionada: ${json.encode(transaction)}');
  }

  /// Recupera todas as transações
  Future<List<Map<String, dynamic>>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> transactions = prefs.getStringList(_transactionsKey) ?? <String>[];

    List<Map<String, dynamic>> transactionList = transactions
        .map((transaction) => json.decode(transaction) as Map<String, dynamic>)
        .toList();
    print('Transações recuperadas: $transactionList');
    return transactionList;
  }

  /// Limpa todos os dados armazenados
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Todos os dados foram limpos.');
  }

  /// Salva o portfólio do usuário (Map<String, double>)
  Future<void> saveUserPortfolio(Map<String, double> portfolio) async {
    final prefs = await SharedPreferences.getInstance();
    // Converte o Map<String, double> em um Map<String, dynamic> para encode
    Map<String, dynamic> dynamicPortfolio = portfolio.map((key, value) => MapEntry(key, value));
    String portfolioJson = json.encode(dynamicPortfolio);
    await prefs.setString(_portfolioKey, portfolioJson);
    print('Portfólio salvo: $portfolioJson');
  }

  /// Recupera o portfólio do usuário (Map<String, double>)
  Future<Map<String, double>?> getUserPortfolio() async {
    final prefs = await SharedPreferences.getInstance();
    String? portfolioJson = prefs.getString(_portfolioKey);
    if (portfolioJson != null) {
      Map<String, dynamic> dynamicPortfolio = json.decode(portfolioJson);
      Map<String, double> portfolio = dynamicPortfolio.map((key, value) => MapEntry(key, value.toDouble()));
      print('Portfólio recuperado: $portfolio');
      return portfolio;
    }
    print('Nenhum portfólio encontrado.');
    return null;
  }
}
