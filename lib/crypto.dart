import 'package:flutter/material.dart';
import 'educacao.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  int _selectedIndex = 1;

  String _selectedCurrency1 = 'BRLA';
  String _selectedCurrency2 = 'GLQ';

  static const List<Widget> _pages = <Widget>[
    Text('Dollar Page'),
    Text('Bitcoin Page'),
    Text('Bank Page'),
  ];

  static const double _sectionSpacing = 30.0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      // Índice do ícone direito
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EducacaoPage()),
      );
    }
  }

  void _onCurrency1Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCurrency1 = newValue;
      });
    }
  }

  void _onCurrency2Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCurrency2 = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C33),
      body: SafeArea(
        child: SingleChildScrollView(
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
                _buildTransactionWidget(context),
                const SizedBox(height: _sectionSpacing),
                _buildWalletSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
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
      ),
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
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'Saldo: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '274.235,12',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/icon.png'),
          radius: 30,
        ),
      ],
    );
  }

  Widget _buildTransactionWidget(BuildContext context) {
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
          _buildDropdownInput(
              context, 'BRLA', _selectedCurrency1, _onCurrency1Changed),
          const SizedBox(height: 10),
          const Icon(Icons.arrow_downward, color: Colors.white),
          const SizedBox(height: 10),
          _buildDropdownInput(
              context, 'GLQ', _selectedCurrency2, _onCurrency2Changed),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gas: 0.0',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Handle transaction action here
            },
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

  Widget _buildDropdownInput(BuildContext context, String currencyLabel,
      String selectedCurrency, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '0.0',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: DropdownButton<String>(
              value: selectedCurrency,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: const Color(0xFF0F1C33),
              underline: const SizedBox(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              items: <String>['BRLA', 'GLQ'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: onChanged,
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
        _buildWalletItem('assets/images/chart.png'),
        _buildWalletItem('assets/images/chart.png'),
        _buildWalletItem('assets/images/chart.png'),
        const SizedBox(height: 20),
        _buildWalletStatusRow(),
      ],
    );
  }

  Widget _buildWalletStatusRow() {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Image.asset(
            'assets/images/metamask.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red, size: 30);
            },
          ),
        ),
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

  Widget _buildWalletItem(String chartImagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(chartImagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
          border: Border.all(
            color: const Color(0xFFCCCC99),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text('W', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WECO',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '-12%',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
