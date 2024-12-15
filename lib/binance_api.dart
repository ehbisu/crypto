// lib/api/binance_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'hmac_sha256.dart';

class BinanceApi {
  final String apiKey = '8l6IBAn4fn9uysNJavpUQfBFqfCuOvGYbskPkqNHTEysrJ3KVU0vTjlfY6H2dOGr';
  final String secretKey = 'ivbU2cTwVDn8l7M8wK8cQTWakROzhVVuVyKFApU7SxcBQs3mVXzPO9iaR4nWsG6I';
  final String baseUrl = 'https://api.binance.com';

  // Singleton pattern (opcional)
  static final BinanceApi _instance = BinanceApi._internal();
  factory BinanceApi() => _instance;
  BinanceApi._internal();

  /// Retorna informações da conta
  Future<Map<String, dynamic>> getAccountInfo() async {
    String endpoint = '/api/v3/account';
    Map<String, dynamic> query = {
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'recvWindow': '5000',
    };

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching account info: ${response.body}');
    }
  }

  /// Cria nova ordem
  Future<Map<String, dynamic>> createOrder({
    required String symbol,
    required String side, // 'BUY' ou 'SELL'
    required String type, // 'LIMIT', 'MARKET', etc.
    String? timeInForce,
    double? quantity,
    double? price,
    double? stopPrice,
  }) async {
    String endpoint = '/api/v3/order';
    Map<String, dynamic> query = {
      'symbol': symbol,
      'side': side,
      'type': type,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    if (type == 'LIMIT') {
      if (price == null || quantity == null || timeInForce == null) {
        throw Exception('Price, Quantity e TimeInForce são obrigatórios para ordens LIMIT.');
      }
      query.addAll({
        'timeInForce': timeInForce,
        'quantity': quantity.toString(),
        'price': price.toString(),
      });
    } else if (type == 'MARKET') {
      if (quantity == null) {
        throw Exception('Quantity é obrigatório para ordens MARKET.');
      }
      query['quantity'] = quantity.toString();
    }

    if (stopPrice != null) {
      query['stopPrice'] = stopPrice.toString();
    }

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.post(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error creating order: ${response.body}');
    }
  }

  /// Cancela uma ordem
  Future<Map<String, dynamic>> cancelOrder({
    required String symbol,
    required int orderId,
  }) async {
    String endpoint = '/api/v3/order';
    Map<String, dynamic> query = {
      'symbol': symbol,
      'orderId': orderId.toString(),
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.delete(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error canceling order: ${response.body}');
    }
  }

  /// Detalhes de uma ordem
  Future<Map<String, dynamic>> getOrder({
    required String symbol,
    int? orderId,
    String? origClientOrderId,
  }) async {
    String endpoint = '/api/v3/order';
    Map<String, dynamic> query = {
      'symbol': symbol,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    if (orderId != null) {
      query['orderId'] = orderId.toString();
    } else if (origClientOrderId != null) {
      query['origClientOrderId'] = origClientOrderId;
    } else {
      throw Exception('Either orderId or origClientOrderId must be provided.');
    }

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching order: ${response.body}');
    }
  }

  /// Ordens abertas
  Future<List<dynamic>> getOpenOrders({String? symbol}) async {
    String endpoint = '/api/v3/openOrders';
    Map<String, dynamic> query = {
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    if (symbol != null) {
      query['symbol'] = symbol;
    }

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching open orders: ${response.body}');
    }
  }

  /// Trades da conta
  Future<List<dynamic>> getAccountTrades({
    required String symbol,
    int? fromId,
  }) async {
    String endpoint = '/api/v3/myTrades';
    Map<String, dynamic> query = {
      'symbol': symbol,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    if (fromId != null) {
      query['fromId'] = fromId.toString();
    }

    String signature = HmacSha256.generateSignature(query, secretKey);
    query['signature'] = signature;

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri, headers: {'X-MBX-APIKEY': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching account trades: ${response.body}');
    }
  }

  /// Preço médio atual
  Future<Map<String, dynamic>> getAveragePrice(String symbol) async {
    String endpoint = '/api/v3/avgPrice';
    Map<String, dynamic> query = {
      'symbol': symbol,
    };

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching average price: ${response.body}');
    }
  }

  /// Todos os símbolos e seus últimos preços
  Future<List<TickerPrice>> getAllPrices() async {
    String endpoint = '/api/v3/ticker/price';
    Uri uri = Uri.parse('$baseUrl$endpoint');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => TickerPrice.fromJson(item)).toList();
    } else {
      throw Exception('Error fetching all prices: ${response.body}');
    }
  }

  /// Preço para um símbolo específico
  Future<double> getPrice(String symbol) async {
    String endpoint = '/api/v3/ticker/price';
    Map<String, dynamic> query = {
      'symbol': symbol,
    };
    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return double.parse(data['price']);
    } else {
      throw Exception('Error fetching price for $symbol: ${response.body}');
    }
  }

  /// 24hr ticker
  Future<List<dynamic>> get24HrTickerPriceChange() async {
    String endpoint = '/api/v3/ticker/24hr';
    Uri uri = Uri.parse('$baseUrl$endpoint');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error fetching 24hr ticker price change: ${response.body}');
    }
  }

  /// Obter dados de velas (Klines) para um símbolo
  /// interval: Exemplo '1m', '5m', '15m', '1h', etc.
  /// limit: número de candles
  Future<List<List<dynamic>>> getKlines(String symbol, {String interval = '1m', int limit = 5}) async {
    String endpoint = '/api/v3/klines';
    Map<String, dynamic> query = {
      'symbol': symbol,
      'interval': interval,
      'limit': limit.toString(),
    };

    Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // data é uma lista de listas
      return data.map((e) => e as List<dynamic>).toList();
    } else {
      throw Exception('Error fetching klines: ${response.body}');
    }
  }
}

/// Model for Ticker Price
class TickerPrice {
  final String symbol;
  final double price;

  TickerPrice({required this.symbol, required this.price});

  factory TickerPrice.fromJson(Map<String, dynamic> json) {
    return TickerPrice(
      symbol: json['symbol'],
      price: double.parse(json['price']),
    );
  }
}
