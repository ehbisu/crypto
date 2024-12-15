// lib/pages/crypto_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import '../binance_api.dart';
import '../local_storage_helper.dart';
import 'educacao.dart';
import 'rendafixa.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  int _selectedIndex = 1;

  String? _selectedCurrency1;
  String? _selectedCurrency2;

  final TextEditingController _amountController1 = TextEditingController();
  final TextEditingController _amountController2 = TextEditingController();

  static const double _sectionSpacing = 30.0;

  final BinanceApi _binanceApi = BinanceApi();

  final List<String> _cryptoList = [
    'BTCUSDT',
    'ETHUSDT',
    'BNBUSDT',
    'XRPUSDT',
    'ADAUSDT',
    'SOLUSDT',
    'DOGEUSDT',
    'MATICUSDT',
    'LTCUSDT',
    'DOTUSDT',
  ];

  Map<String, double> _prices = {};
  bool _isLoading = true;

  final LocalStorageHelper _storageHelper = LocalStorageHelper();

  double _userSaldo = 0.0;
  Map<String, double> _portfolio = {};
  List<Map<String, dynamic>> _transactions = [];
  Map<String, List<double>> _historicalData = {};

  String _userName = "";

  @override
  void initState() {
    super.initState();
    _loadData();
    // Update the conversion whenever from-amount changes.
    _amountController1.addListener(() {
      _updateExchangeAmount(); 
    });
  }

  Future<void> _loadData() async {
    await _fetchPrices();
    await _initializeUserSaldoAndPortfolio();
    await _fetchTransactions();
    await _fetchHistoricalDataForAll();
    await _fetchUserName();

    _adjustSelectedCurrencies();

    // If after adjustments we still have no from currency but have a portfolio, select the first one
    if (_selectedCurrency1 == null && _portfolio.isNotEmpty) {
      _selectedCurrency1 = _portfolio.keys.first;
    }

    // If after adjustments we still have no to currency but have cryptos, select the first one
    if (_selectedCurrency2 == null && _cryptoList.isNotEmpty) {
      _selectedCurrency2 = _cryptoList.first;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _adjustSelectedCurrencies() {
    // Adjust the from currency if it is no longer valid
    if (_selectedCurrency1 != null && !_portfolio.keys.contains(_selectedCurrency1!)) {
      if (_portfolio.isNotEmpty) {
        _selectedCurrency1 = _portfolio.keys.first;
      } else {
        _selectedCurrency1 = null;
      }
    }

    // Adjust the to currency if it is no longer valid
    if (_selectedCurrency2 != null && !_cryptoList.contains(_selectedCurrency2!)) {
      if (_cryptoList.isNotEmpty) {
        _selectedCurrency2 = _cryptoList.first;
      } else {
        _selectedCurrency2 = null;
      }
    }

    // If no portfolio, no from currency
    if (_portfolio.isEmpty) {
      _selectedCurrency1 = null;
    }

    // If no crypto list, no to currency
    if (_cryptoList.isEmpty) {
      _selectedCurrency2 = null;
    }
  }

  Future<void> _fetchUserName() async {
    Map<String, dynamic>? userData = await _storageHelper.getUserData();
    if (userData != null && userData['usuario'] != null) {
      _userName = userData['usuario'];
    } else {
      _userName = "User";
    }
  }

  Future<void> _fetchPrices() async {
    try {
      List<TickerPrice> allPrices = await _binanceApi.getAllPrices();
      for (var ticker in allPrices) {
        if (_cryptoList.contains(ticker.symbol)) {
          _prices[ticker.symbol] = ticker.price;
        }
      }
    } catch (e) {
      print('Error fetching prices: $e');
    }
  }

  Future<void> _fetchHistoricalDataForAll() async {
    for (var symbol in _cryptoList) {
      try {
        List<List<dynamic>> klines = await _binanceApi.getKlines(symbol, interval: '1m', limit: 5);
        List<double> closes = klines.map((k) => double.parse(k[4])).toList();
        _historicalData[symbol] = closes;
      } catch (e) {
        print("Erro ao buscar dados históricos para $symbol: $e");
        _historicalData[symbol] = [];
      }
    }
  }

  Future<void> _initializeUserSaldoAndPortfolio() async {
    double saldo = await _storageHelper.getUserSaldo();
    if (saldo == 0.0) {
      await _updateUserSaldo(10000.0);
    } else {
      _userSaldo = saldo;
    }

    Map<String, double>? storedPortfolio = await _storageHelper.getUserPortfolio();
    if (storedPortfolio == null) {
      _portfolio = {};
      await _storageHelper.saveUserPortfolio(_portfolio);
    } else {
      _portfolio = storedPortfolio;
    }
  }

  Future<void> _fetchTransactions() async {
    _transactions = await _storageHelper.getTransactions();
  }

  Future<void> _updateUserSaldo(double newSaldo) async {
    await _storageHelper.saveUserSaldo(newSaldo);
    _userSaldo = newSaldo;
  }

  Future<void> _updatePortfolio() async {
    await _storageHelper.saveUserPortfolio(_portfolio);
  }

  Future<void> _handleBuy(String symbol, double quantity) async {
    try {
      double price = _prices[symbol] ?? await _binanceApi.getPrice(symbol);
      double totalCost = price * quantity;

      if (_userSaldo < totalCost) {
        _showErrorDialog('Saldo insuficiente para esta compra.');
        return;
      }

      double newSaldo = _userSaldo - totalCost;
      await _updateUserSaldo(newSaldo);

      _portfolio[symbol] = (_portfolio[symbol] ?? 0.0) + quantity;
      await _updatePortfolio();
      await _storageHelper.addTransaction({
        'symbol': symbol,
        'side': 'BUY',
        'quantity': quantity,
        'price': price,
        'timestamp': DateTime.now().toIso8601String(),
      });
      await _fetchTransactions();

      _adjustSelectedCurrencies();

      _showSuccessDialog('Compra realizada com sucesso!');
      setState(() {});
    } catch (e) {
      _showErrorDialog('Erro ao realizar compra: $e');
    }
  }

  Future<void> _handleSell(String symbol, double quantity) async {
    try {
      double userQuantity = _portfolio[symbol] ?? 0.0;
      if (userQuantity < quantity) {
        _showErrorDialog('Você não possui quantidade suficiente de $symbol para vender.');
        return;
      }

      double price = _prices[symbol] ?? await _binanceApi.getPrice(symbol);
      double totalRevenue = price * quantity;

      _portfolio[symbol] = userQuantity - quantity;
      if (_portfolio[symbol]! <= 0) {
        _portfolio.remove(symbol);
      }
      await _updatePortfolio();

      double newSaldo = _userSaldo + totalRevenue;
      await _updateUserSaldo(newSaldo);

      await _storageHelper.addTransaction({
        'symbol': symbol,
        'side': 'SELL',
        'quantity': quantity,
        'price': price,
        'timestamp': DateTime.now().toIso8601String(),
      });
      await _fetchTransactions();

      _adjustSelectedCurrencies();

      _showSuccessDialog('Venda realizada com sucesso!');
      setState(() {});
    } catch (e) {
      _showErrorDialog('Erro ao realizar venda: $e');
    }
  }

  Future<void> _handleExchange() async {
    if (_selectedCurrency1 == null || _selectedCurrency2 == null) {
      _showErrorDialog('Selecione as moedas para a troca.');
      return;
    }

    double fromAmount = double.tryParse(_amountController1.text) ?? 0.0;
    if (fromAmount <= 0) {
      _showErrorDialog('Quantidade inválida para troca.');
      return;
    }

    double userQuantity = _portfolio[_selectedCurrency1!] ?? 0.0;
    if (userQuantity < fromAmount) {
      _showErrorDialog('Você não possui quantidade suficiente de ${_selectedCurrency1!} para a troca.');
      return;
    }

    double price1 = _prices[_selectedCurrency1!] ?? await _binanceApi.getPrice(_selectedCurrency1!);
    double price2 = _prices[_selectedCurrency2!] ?? await _binanceApi.getPrice(_selectedCurrency2!);

    double totalValue = fromAmount * price1;
    double gasFee = _calculateGasFeeFiat(fromAmount, price1);
    double finalValue = totalValue - gasFee;
    if (finalValue <= 0) {
      _showErrorDialog('Valor após taxa de gás insuficiente para troca.');
      return;
    }

    double toAmount = finalValue / price2;

    _portfolio[_selectedCurrency1!] = userQuantity - fromAmount;
    if (_portfolio[_selectedCurrency1!]! <= 0) {
      _portfolio.remove(_selectedCurrency1!);
    }

    _portfolio[_selectedCurrency2!] = (_portfolio[_selectedCurrency2!] ?? 0.0) + toAmount;
    await _updatePortfolio();

    await _storageHelper.addTransaction({
      'symbol': _selectedCurrency1!,
      'side': 'EXCHANGE_OUT',
      'quantity': fromAmount,
      'price': price1,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await _storageHelper.addTransaction({
      'symbol': _selectedCurrency2!,
      'side': 'EXCHANGE_IN',
      'quantity': toAmount,
      'price': price2,
      'timestamp': DateTime.now().toIso8601String(),
    });

    await _fetchTransactions();

    _adjustSelectedCurrencies();
    _showSuccessDialog('Troca realizada com sucesso!');
    _updateExchangeAmount();
    setState(() {});
  }

  void _updateExchangeAmount() {
    if (_selectedCurrency1 == null || _selectedCurrency2 == null) {
      _amountController2.text = '';
      return;
    }

    double fromAmount = double.tryParse(_amountController1.text) ?? 0.0;
    if (fromAmount <= 0) {
      _amountController2.text = '';
      return;
    }

    double? price1 = _prices[_selectedCurrency1!];
    double? price2 = _prices[_selectedCurrency2!];

    if (price1 == null || price2 == null) {
      _amountController2.text = '';
      return;
    }

    double gasFeeFiat = _calculateGasFeeFiat(fromAmount, price1);
    double finalValue = fromAmount * price1 - gasFeeFiat;
    double toAmount = finalValue > 0 ? finalValue / price2 : 0.0;

    _amountController2.text = toAmount.toStringAsFixed(6);
  }

  double _calculateGasFee() {
    double amount = double.tryParse(_amountController1.text) ?? 0.0;
    return amount * 0.01;
  }

  double _calculateGasFeeFiat(double amount, double price1) {
    return amount * price1 * 0.01;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sucesso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.green),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTransactionDialog() {
    _handleExchange();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RendaFixaPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EducacaoPage()),
      );
    }
  }

  IconData _getCryptoIcon(String symbol) {
    if (symbol.startsWith('BTC')) return CupertinoIcons.bitcoin_circle;
    if (symbol.startsWith('ETH')) return Icons.auto_awesome;
    if (symbol.startsWith('BNB')) return Icons.auto_fix_high;
    if (symbol.startsWith('XRP')) return Icons.waves;
    if (symbol.startsWith('ADA')) return Icons.fiber_smart_record;
    if (symbol.startsWith('SOL')) return Icons.brightness_5;
    if (symbol.startsWith('DOGE')) return Icons.pets;
    if (symbol.startsWith('MATIC')) return Icons.scatter_plot;
    if (symbol.startsWith('LTC')) return Icons.lightbulb_outline;
    if (symbol.startsWith('DOT')) return Icons.circle;
    return Icons.monetization_on;
  }

  String _shortenSymbol(String symbol) {
    String short = symbol.replaceAll('USDT', '');
    if (short.length > 6) {
      short = short.substring(0, 6).toUpperCase();
    } else {
      short = short.toUpperCase();
    }
    return short;
  }

  Widget _buildMiniChart(String symbol) {
    List<double>? data = _historicalData[symbol];
    if (data == null || data.isEmpty) {
      return Container(
        width: 50,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: const Text(
          '-',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      );
    }

    return Container(
      width: 50,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomPaint(
        painter: _ChartPainter(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C33),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 32.0,
                    bottom: 80.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: _sectionSpacing),
                      if (_portfolio.isNotEmpty) _buildTransactionWidget(context),
                      if (_portfolio.isNotEmpty) const SizedBox(height: _sectionSpacing),
                      _buildWalletSection(),
                      const SizedBox(height: _sectionSpacing),
                      _buildCryptoList(),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'EBISU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  const TextSpan(
                    text: 'Saldo: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '\$${_userSaldo.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              _userName,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/icon.png'),
              radius: 30,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionWidget(BuildContext context) {
    if (_portfolio.isEmpty) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 51, 82),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCCCC99),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Crypto Swap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // From field
          if (_portfolio.isNotEmpty)
            _buildDropdownInput(
              context,
              _selectedCurrency1,
              _amountController1,
              _portfolio.keys.toList(),
              isFromCurrency: true,
              readOnly: false,
            ),

          if (_portfolio.isNotEmpty) const SizedBox(height: 10),
          if (_portfolio.isNotEmpty) const Icon(Icons.arrow_downward, color: Colors.white),
          if (_portfolio.isNotEmpty) const SizedBox(height: 10),

          // To field
          if (_portfolio.isNotEmpty && _cryptoList.isNotEmpty)
            _buildDropdownInput(
              context,
              _selectedCurrency2,
              _amountController2,
              _cryptoList,
              isFromCurrency: false,
              readOnly: true,
            ),

          if (_portfolio.isNotEmpty) const SizedBox(height: 20),
          if (_portfolio.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gas: ${_calculateGasFee().toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          if (_portfolio.isNotEmpty) const SizedBox(height: 20),

          if (_portfolio.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _showTransactionDialog,
              child: const Center(
                child: Text(
                  'INICIAR TRANSAÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownInput(
    BuildContext context,
    String? selectedCurrency,
    TextEditingController controller,
    List<String> items, {
    required bool isFromCurrency,
    required bool readOnly,
  }) {
    final validSelectedCurrency = (selectedCurrency != null && items.contains(selectedCurrency))
        ? selectedCurrency
        : (items.isNotEmpty ? items.first : null);

    if (items.isEmpty) {
      return const SizedBox();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: const InputDecoration(
                  hintText: '0.0',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: DropdownButton<String>(
              isDense: true,
              value: validSelectedCurrency,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: const Color(0xFF0F1C33),
              underline: const SizedBox(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(_shortenSymbol(value)),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    if (isFromCurrency) {
                      _selectedCurrency1 = newValue;
                    } else {
                      _selectedCurrency2 = newValue;
                    }
                    _updateExchangeAmount();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ID: 0x3F7a1c6E12B9087c...',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        if (_portfolio.isEmpty)
          const Text(
            'Você não possui nenhuma criptomoeda.',
            style: TextStyle(color: Colors.white70),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _portfolio.length,
            itemBuilder: (context, index) {
              String symbol = _portfolio.keys.elementAt(index);
              double quantity = _portfolio[symbol]!;
              return _buildWalletItem(symbol, quantity);
            },
          ),
        const SizedBox(height: 20),
        _buildWalletStatusRow(),
      ],
    );
  }

  Widget _buildWalletItem(String symbol, double quantity) {
    double price = _prices[symbol] ?? 0.0;
    double totalValue = quantity * price;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 34, 51, 82),
          border: Border.all(
            color: const Color(0xFFCCCC99),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(_getCryptoIcon(symbol), color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _shortenSymbol(symbol),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Qtd: $quantity',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'Valor: \$${totalValue.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildMiniChart(symbol),
            const SizedBox(width: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_upward, color: Colors.green),
                  onPressed: () {
                    _showBuyDialog(symbol);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward, color: Colors.red),
                  onPressed: () {
                    _showSellDialog(symbol);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletStatusRow() {
    return Row(
      children: [
        const Icon(Icons.link, color: Colors.green),
        const SizedBox(width: 10),
        const Text(
          'Status: ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Connected',
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Cryptocurrencies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _cryptoList.length,
          itemBuilder: (context, index) {
            String symbol = _cryptoList[index];
            double price = _prices[symbol] ?? 0.0;

            return Card(
              color: const Color.fromARGB(255, 34, 51, 82),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: Icon(_getCryptoIcon(symbol), color: Colors.white),
                title: Text(
                  _shortenSymbol(symbol),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMiniChart(symbol),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.green),
                      onPressed: () => _showBuyDialog(symbol),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.red),
                      onPressed: () => _showSellDialog(symbol),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showBuyDialog(String symbol) {
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Comprar ${_shortenSymbol(symbol)}'),
        content: TextField(
          controller: quantityController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Quantidade',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              double quantity = double.tryParse(quantityController.text) ?? 0.0;
              if (quantity > 0) {
                Navigator.of(ctx).pop();
                await _handleBuy(symbol, quantity);
                setState(() {});
              } else {
                _showErrorDialog('Quantidade inválida.');
              }
            },
            child: const Text('Comprar'),
          ),
        ],
      ),
    );
  }

  void _showSellDialog(String symbol) {
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Vender ${_shortenSymbol(symbol)}'),
        content: TextField(
          controller: quantityController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Quantidade',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              double quantity = double.tryParse(quantityController.text) ?? 0.0;
              if (quantity > 0) {
                Navigator.of(ctx).pop();
                await _handleSell(symbol, quantity);
                setState(() {});
              } else {
                _showErrorDialog('Quantidade inválida.');
              }
            },
            child: const Text('Vender'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 24, 38, 64),
        iconSize: 30.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> data;
  _ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double maxPrice = data.reduce(math.max);
    double minPrice = data.reduce(math.min);

    double range = (maxPrice == minPrice) ? 1 : (maxPrice - minPrice);

    Path path = Path();
    for (int i = 0; i < data.length; i++) {
      double x = (i / (data.length - 1)) * size.width;
      double normalized = (data[i] - minPrice) / range;
      double y = size.height - (normalized * size.height);

      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChartPainter oldDelegate) => false;
}
