import 'package:flutter/material.dart';

class EducacaoPage extends StatefulWidget {
  const EducacaoPage({super.key});

  @override
  State<EducacaoPage> createState() => _EducacaoPageState();
}

class _EducacaoPageState extends State<EducacaoPage> {
  int _selectedIndex = 2; // Definindo o índice inicial como 2 para a página atual

  double _userSaldo = 0.0;
  String _userName = "User";
  final LocalStorageHelper _storageHelper = LocalStorageHelper();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    double saldo = await _storageHelper.getUserSaldo();
    Map<String, dynamic>? userData = await _storageHelper.getUserData();
    String userName = "User";
    if (userData != null && userData['usuario'] != null) {
      userName = userData['usuario'];
    }

    setState(() {
      _userSaldo = saldo;
      _userName = userName;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CryptoPage()),
      );
    }
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RendaFixaPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C33),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const EducacaoTitle(),
            const EducacaoSubtitle(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: InvestmentList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Alteramos as cores para ficarem mais contrastantes.
    // O fundo é escuro, então o texto em branco total será mais visível.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'EBISU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8), 
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    const TextSpan(
                      text: 'Saldo: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: userSaldo.toStringAsFixed(2),
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
                userName,
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
      ),
    );
  }
}

class EducacaoTitle extends StatelessWidget {
  const EducacaoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // Manter texto em branco para melhor contraste
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Learn',
        style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class EducacaoSubtitle extends StatelessWidget {
  const EducacaoSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    // Manter texto em branco70, mas ainda assim contrastante com o fundo
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Explore o mundo dos investimentos',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

class InvestmentList extends StatelessWidget {
  final int numberOfCourses;

  const InvestmentList({this.numberOfCourses = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: numberOfCourses,
      itemBuilder: (context, index) {
        return const InvestmentCard();
      },
    );
  }
}


class InvestmentCard extends StatelessWidget {
  const InvestmentCard();

  @override
  Widget build(BuildContext context) {
    // Remover qualquer borda ou divisor extra. Remover a Divider.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xFF244673),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(
            'images/agro.png',
            width: 80,
            height: 60,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
          title: const Text(
            'LCI/LCA',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 4),
              Text(
                'Como funciona: Investir no agro e no setor imobiliário',
                style: TextStyle(color: Colors.white70),
              ),
              Divider(color: Colors.white38),
            ],
          ),
        ),
      ),
    );
  }
}


class EducacaoBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const EducacaoBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
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
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
