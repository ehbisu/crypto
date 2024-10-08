import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Manage the selected currency state here
  String _selectedCurrency1 = 'BRLA';
  String _selectedCurrency2 = 'GLQ';

  static const List<Widget> _pages = <Widget>[
    Text('Dollar Page'),
    Text('Bitcoin Page'),
    Text('Bank Page'),
  ];

  // Define a constant for spacing between main sections
  static const double _sectionSpacing = 30.0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to handle first currency change
  void _onCurrency1Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCurrency1 = newValue;
      });
    }
  }

  // Function to handle second currency change
  void _onCurrency2Changed(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCurrency2 = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0F1C33), // Dark blue background color
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 32.0, // Increased top padding
                bottom:
                    80.0, // Prevent content from hiding behind BottomNavigationBar
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Profile and Balance as the Header
                  _buildProfileSection(),

                  const SizedBox(height: _sectionSpacing), // Increased spacing

                  // Section: Transaction widget
                  _buildTransactionWidget(context),

                  const SizedBox(height: _sectionSpacing), // Increased spacing

                  // Section: Wallet info
                  _buildWalletSection(),
                ],
              ),
            ),
          ),
        ),
        // Bottom Navigation Bar wrapped with Theme to override splash effects
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // Disable the default splash and highlight colors
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 24, 38, 64), // Slightly different dark blue shade for the BottomNavigationBar
            iconSize: 30.0, // Icon size
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
            showSelectedLabels: false, // Hide labels for cleaner look
            showUnselectedLabels: false, // Hide labels for cleaner look
            selectedItemColor: Colors.yellow, // Color for the selected icon
            unselectedItemColor: Colors.white, // Color for unselected icons
            type: BottomNavigationBarType.fixed, // Ensures fixed positioning
          ),
        ),
      ),
    );
  }

  // Profile and balance widget (Header)
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

  // Transaction widget
  Widget _buildTransactionWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 51, 82), // Dark blue background color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCCCC99), // Light yellow border color
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // First dropdown and input
          _buildDropdownInput(
              context, 'BRLA', _selectedCurrency1, _onCurrency1Changed),

          const SizedBox(height: 10),

          // Arrow icon
          const Icon(Icons.arrow_downward, color: Colors.white),

          const SizedBox(height: 10),

          // Second dropdown and input
          _buildDropdownInput(
              context, 'GLQ', _selectedCurrency2, _onCurrency2Changed),

          const SizedBox(height: 20),

          // Gas info
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gas: 0.0',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),

          // Action button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF00C853), // Green button color
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

  // Reusable dropdown input with a text field
  Widget _buildDropdownInput(BuildContext context, String currencyLabel,
      String selectedCurrency, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02), // Super light transparent background
        // Alternatively, use a semi-transparent color:
        // color: Colors.white.withOpacity(0.05),
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
                  color: Color(0xFF666666), // Dark gray text color
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
              dropdownColor:
                  const Color(0xFF0F1C33), // Dark blue for dropdown menu
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

  // Wallet section widget
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
        // Simulated Wallet Items (replace with real data if needed)
        _buildWalletItem('assets/images/chart.png'),
        _buildWalletItem('assets/images/chart.png'),
        _buildWalletItem('assets/images/chart.png'),
        const SizedBox(height: 20),
        // Status section
        _buildWalletStatusRow(), // Updated method
      ],
    );
  }

  // Updated Wallet Status Row to prevent overflow
  Widget _buildWalletStatusRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // Constrained Image
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(
                'assets/images/metamask.png', // Corrected to forward slashes
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red, size: 30);
                },
              ),
            ),
            const SizedBox(width: 10),
            // "Status:" Text
            const Text(
              'Status: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // "Connected" Text wrapped with Expanded to prevent overflow
            const Expanded(
              child: Text(
                'Connected',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis, // Truncate if too long
              ),
            ),
          ],
        );
      },
    );
  }

  // Single wallet item widget with chart image as background
  Widget _buildWalletItem(String chartImagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // Make the entire container have the background image
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(chartImagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ), // Optional: darken the image for better text visibility
          ),
          border: Border.all(
            color: const Color(0xFFCCCC99), // Light yellow border color
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
            // Optionally, you can add more details here
          ],
        ),
      ),
    );
  }
}
