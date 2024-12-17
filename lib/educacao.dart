import 'package:flutter/material.dart';
import 'crypto.dart';
import 'rendafixa.dart';
import '../local_storage_helper.dart'; // Import LocalStorageHelper

class EducacaoPage extends StatefulWidget {
  const EducacaoPage({super.key});

  @override
  _EducacaoPageState createState() => _EducacaoPageState();
}

class _EducacaoPageState extends State<EducacaoPage> {
  // Índice inicial da página atual
  int _selectedIndex = 2;

  double _userSaldo = 0.0;
  String _userName = "User";
  final LocalStorageHelper _storageHelper = LocalStorageHelper();

  // Lista de tópicos de investimento (base + novos conteúdos adicionados)
  final List<InvestmentTopic> _topics = [
    InvestmentTopic(
      title: 'Tesouro Direto',
      subtitle: 'Títulos públicos - Segurança e Simplicidade',
      detailText:
          'O Tesouro Direto permite que qualquer pessoa invista em títulos públicos facilmente. Existem títulos prefixados (taxa fixa), pós-fixados (atrelados à Selic) e híbridos (parte fixa e parte atrelada à inflação).\n\nVantagens:\n• Baixo risco, garantido pelo governo.\n• Possibilidade de começar com valores baixos.\n• Fácil acesso online.\n\nIdeal para quem busca segurança e primeiro contato com renda fixa.',
      icon: Icons.savings,
    ),
    InvestmentTopic(
      title: 'LCI/LCA',
      subtitle: 'Crédito Imobiliário e Agrícola',
      detailText:
          'LCI (Letra de Crédito Imobiliário) e LCA (Letra de Crédito do Agronegócio) são títulos emitidos por bancos lastreados no setor imobiliário ou agronegócio.\n\nVantagens:\n• Isenção de IR para pessoa física.\n• Boa segurança (lastro em ativos reais).\n• Rentabilidade geralmente atrelada ao CDI.\n\nÓtima opção para diversificar com isenção de imposto.',
      icon: Icons.agriculture,
    ),
    InvestmentTopic(
      title: 'CDB',
      subtitle: 'Certificado de Depósito Bancário',
      detailText:
          'O CDB é um título emitido por bancos. Pode ser prefixado, pós-fixado (atrelado ao CDI) ou híbrido.\n\nVantagens:\n• Proteção do FGC (até certo limite).\n• Diversos prazos e taxas.\n• Facilidade de aplicação via bancos e corretoras.\n\nPermite diversificar na renda fixa com diferentes bancos.',
      icon: Icons.account_balance,
    ),
    InvestmentTopic(
      title: 'Fundos Imobiliários (FIIs)',
      subtitle: 'Investir em imóveis sem comprá-los diretamente',
      detailText:
          'FIIs reúnem recursos de vários investidores para aplicar em imóveis ou títulos imobiliários.\n\nVantagens:\n• Aluguéis mensais (proventos) isentos de IR.\n• Diversificação em diferentes tipos de imóveis.\n• Maior liquidez que imóveis físicos.\n\nBoa opção para renda passiva diversificada.',
      icon: Icons.location_city,
    ),
    InvestmentTopic(
      title: 'Criptomoedas',
      subtitle: 'Bitcoin, Ethereum e o mundo digital',
      detailText:
          'Criptomoedas são ativos digitais baseados em criptografia e blockchain.\n\nVantagens:\n• Alta liquidez, negociações 24/7.\n• Potencial de valorização.\n\nRiscos:\n• Alta volatilidade.\n• Falta de regulamentação.\n\nIndicado para perfis arrojados e com conhecimento prévio.',
      icon: Icons.currency_bitcoin,
    ),
    InvestmentTopic(
      title: 'Ações e ETFs',
      subtitle: 'Participação em empresas e índices',
      detailText:
          'Investir em ações é se tornar sócio de empresas. ETFs replicam índices, trazendo diversificação.\n\nVantagens:\n• Potencial de retornos mais altos.\n• Diversificação e acesso a mercados internacionais.\n\nRiscos:\n• Volatilidade, sem garantia de retorno.\n\nIdeal para longo prazo e estudo do mercado.',
      icon: Icons.show_chart,
    ),
    // Novos conteúdos adicionados:
    InvestmentTopic(
      title: 'Debêntures',
      subtitle: 'Títulos de dívida corporativa',
      detailText:
          'Debêntures são títulos de dívida emitidos por empresas, sem a garantia do FGC.\n\nVantagens:\n• Potencial de retorno superior a títulos públicos.\n• Diversos prazos e taxas.\n• Possibilidade de debêntures incentivadas.\n\nRiscos:\n• Maior risco de crédito da empresa.\n• Exige análise da saúde financeira da emissora.',
      icon: Icons.description,
    ),
    InvestmentTopic(
      title: 'Poupança',
      subtitle: 'Investimento tradicional',
      detailText:
          'A poupança é simples, garantida pelo FGC e muito acessível, porém com baixa rentabilidade.\n\nVantagens:\n• Alta liquidez.\n• Garantia do FGC.\n• Isenção de IR.\n\nDesvantagens:\n• Rendimento baixo, abaixo da inflação.\n• Menos atrativa frente a outros investimentos.',
      icon: Icons.account_balance_wallet,
    ),
    InvestmentTopic(
      title: 'Previdência Privada',
      subtitle: 'Planejamento de longo prazo',
      detailText:
          'A previdência privada (PGBL/VGBL) é voltada para aposentadoria e longo prazo.\n\nVantagens:\n• Benefícios fiscais (PGBL).\n• Flexibilidade nos aportes.\n• Diversidade de fundos.\n\nDesvantagens:\n• Taxas de administração podem ser altas.\n• Exige horizonte de longo prazo.',
      icon: Icons.security,
    ),
    InvestmentTopic(
      title: 'Fundos de Investimento',
      subtitle: 'Gestão profissional',
      detailText:
          'Fundos reúnem recursos de vários investidores em carteira diversificada, gerida por profissionais.\n\nVantagens:\n• Gestão profissional.\n• Diversificação automática.\n• Acesso a mercados complexos.\n\nDesvantagens:\n• Taxas de administração.\n• Liquidez variável.',
      icon: Icons.assessment,
    ),
    InvestmentTopic(
      title: 'Opções',
      subtitle: 'Derivativos de renda variável',
      detailText:
          'Opções dão direito de comprar/vender um ativo a um preço pré-fixado. Usadas para especulação ou hedge.\n\nVantagens:\n• Estratégias flexíveis.\n• Possibilidade de hedge.\n\nRiscos:\n• Alta complexidade e risco.\n• Volatilidade influencia preços.',
      icon: Icons.swap_vert,
    ),
    InvestmentTopic(
      title: 'Commodities',
      subtitle: 'Investimento em bens físicos',
      detailText:
          'Commodities (ouro, petróleo, soja) podem proteger contra inflação e diversificar a carteira.\n\nVantagens:\n• Proteção contra inflação.\n• Diversificação.\n\nRiscos:\n• Alta volatilidade.\n• Influência geopolítica e climática.',
      icon: Icons.landscape,
    ),
    InvestmentTopic(
      title: 'REITs',
      subtitle: 'Real Estate Investment Trusts',
      detailText:
          'REITs permitem investir em imóveis (no exterior) e receber dividendos, com gestão profissional.\n\nVantagens:\n• Dividendos regulares.\n• Diversificação internacional.\n\nRiscos:\n• Variação cambial.\n• Volatilidade de mercado.',
      icon: Icons.apartment,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Carrega dados do usuário do armazenamento local
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

  // Função ao clicar nos itens da barra inferior
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
            ProfileHeader(userName: _userName, userSaldo: _userSaldo),
            const EducacaoTitle(),
            const EducacaoSubtitle(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InvestmentList(topics: _topics),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EducacaoBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final double userSaldo;
  final String userName;

  const ProfileHeader({required this.userName, required this.userSaldo});

  @override
  Widget build(BuildContext context) {
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
  const EducacaoTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Learn',
        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class EducacaoSubtitle extends StatelessWidget {
  const EducacaoSubtitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Como pescar no mundo dos investimentos',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

class InvestmentTopic {
  final String title;
  final String subtitle;
  final String detailText;
  final IconData icon;

  InvestmentTopic({
    required this.title,
    required this.subtitle,
    required this.detailText,
    required this.icon,
  });
}

class InvestmentList extends StatelessWidget {
  final List<InvestmentTopic> topics;

  const InvestmentList({required this.topics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        return InvestmentCard(topic: topics[index]);
      },
    );
  }
}

class InvestmentCard extends StatefulWidget {
  final InvestmentTopic topic;

  const InvestmentCard({required this.topic});

  @override
  State<InvestmentCard> createState() => _InvestmentCardState();
}

class _InvestmentCardState extends State<InvestmentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF244673),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                _isExpanded = value;
              });
            },
            tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            leading: Icon(widget.topic.icon, size: 40, color: Colors.yellowAccent),
            title: Text(
              widget.topic.title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.topic.subtitle,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.topic.detailText,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
            textColor: Colors.white,
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.white,
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