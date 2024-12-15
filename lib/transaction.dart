// models/transaction.dart
class TransactionModel {
  final int? id;
  final String symbol;
  final String side;
  final double quantity;
  final double price;
  final String timestamp;

  TransactionModel({
    this.id,
    required this.symbol,
    required this.side,
    required this.quantity,
    required this.price,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'side': side,
      'quantity': quantity,
      'price': price,
      'timestamp': timestamp,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      symbol: map['symbol'],
      side: map['side'],
      quantity: map['quantity'],
      price: map['price'],
      timestamp: map['timestamp'],
    );
  }
}
