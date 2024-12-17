import 'package:flutter/material.dart';

class EducacaoPage extends StatefulWidget {
  const EducacaoPage({super.key});

  @override
  State<EducacaoPage> createState() => _EducacaoPageState();
}

class _EducacaoPageState extends State<EducacaoPage> {
  final List<Map<String, dynamic>> _investmentData = [
    {
      'title': 'LCI/LCA',
      'subtitle': 'Investindo no Agro e Imobiliário',
      'description':
          'LCI (Letras de Crédito Imobiliário) e LCA (Letras de Crédito do Agronegócio) são investimentos de renda fixa que destinam recursos diretamente para os setores imobiliário e agrícola. Esses títulos são uma excelente alternativa para quem busca isenção de imposto de renda, além de oferecerem segurança por serem garantidos pelo Fundo Garantidor de Créditos (FGC). Entretanto, possuem liquidez limitada, sendo mais indicados para objetivos de médio a longo prazo. Além disso, esses investimentos contribuem para o desenvolvimento econômico dos setores imobiliário e agrícola, proporcionando infraestrutura e expansão que beneficiam a sociedade como um todo. A diversificação em LCI/LCA também permite que os investidores participem de projetos sustentáveis e ambientalmente responsáveis, alinhando seus investimentos com valores pessoais de responsabilidade social e ambiental.',
      'topics': [
        'Isenção de imposto de renda para pessoa física.',
        'Ideal para prazos médios e longos.',
        'Liquidez baixa, geralmente disponível após 3 meses.',
        'Garantido pelo FGC (Fundo Garantidor de Créditos) até R\$250 mil.',
        'Rendimento atrelado ao CDI (de 90% a 100%).',
        'Diversificação em setores imobiliário e agrícola.',
        'Baixo risco em comparação a investimentos de renda variável.',
        'Contribuição para o desenvolvimento de infraestrutura.',
        'Possibilidade de participar de projetos sustentáveis.',
        'Acessível para investidores iniciantes e experientes.',
      ],
      'image': 'images/agro.png',
      'isExpanded': false,
    },
    {
      'title': 'CDB',
      'subtitle': 'Certificado de Depósito Bancário',
      'description':
          'Os Certificados de Depósito Bancário (CDBs) são títulos emitidos por bancos para captar recursos do público. Em troca, os investidores recebem juros como remuneração pelo período do empréstimo. É uma opção atrativa para quem busca segurança e diversificação. Alguns CDBs oferecem liquidez diária, permitindo resgate rápido, enquanto outros têm prazos definidos para maior rendimento. São protegidos pelo FGC, garantindo maior segurança. Além disso, os CDBs podem ser classificados em diferentes tipos, como prefixados, pós-fixados e atrelados à inflação, permitindo que os investidores escolham conforme seu perfil e objetivos financeiros. A flexibilidade na escolha de prazos e taxas de rendimento faz dos CDBs uma ferramenta versátil para planejamento financeiro, seja para a construção de uma reserva de emergência ou para a realização de objetivos de longo prazo. A transparência nas condições de investimento e a facilidade de acesso através de plataformas digitais também tornam os CDBs uma opção popular no mercado de renda fixa.',
      'topics': [
        'Liquidez diária em alguns casos.',
        'Ideal para objetivos de curto a médio prazo.',
        'Garantido pelo FGC até R\$250 mil.',
        'Taxas de rendimento atrativas (até 120% do CDI).',
        'Possibilidade de CDBs prefixados, pós-fixados e atrelados à inflação.',
        'Variedade de prazos e condições oferecidas pelos bancos.',
        'Facilidade de investimento através de plataformas digitais.',
        'Diversificação com diferentes emissores e taxas.',
        'Acessível para investidores com diversos níveis de capital.',
        'Transparência nas taxas e condições de resgate.',
      ],
      'image': 'images/cdb.png',
      'isExpanded': false,
    },
    {
      'title': 'Tesouro Direto',
      'subtitle': 'Títulos Públicos do Governo',
      'description':
          'O Tesouro Direto é uma plataforma criada pelo governo para facilitar o acesso a títulos públicos por investidores pessoa física. Ao investir no Tesouro Direto, você está emprestando dinheiro ao governo em troca de uma remuneração, sendo considerado um dos investimentos mais seguros do mercado. Existem diferentes opções como Tesouro Selic (ideal para reserva de emergência), Tesouro Prefixado (com rendimento fixo) e Tesouro IPCA+ (que protege contra inflação). Além disso, o Tesouro Direto oferece a possibilidade de diversificação entre esses diferentes tipos de títulos, permitindo que os investidores ajustem suas carteiras de acordo com suas necessidades e expectativas de mercado. A plataforma também facilita a gestão dos investimentos com ferramentas online que permitem acompanhar o desempenho dos títulos, realizar simulações e efetuar resgates de forma simples e rápida. A educação financeira é incentivada através de materiais educativos e suporte ao investidor, tornando o Tesouro Direto uma excelente opção para quem deseja começar a investir com segurança e conhecimento.',
      'topics': [
        'Liquidez diária (com taxas caso resgate antes do vencimento).',
        'Opções para aposentadoria e viagens.',
        'Tipos: Tesouro Selic, Prefixado e IPCA+.',
        'Garantia total pelo Governo Federal.',
        'Baixos custos de administração.',
        'Investimento acessível com valores a partir de R\$30.',
        'Possibilidade de investir regularmente com planos automáticos.',
        'Ferramentas online para gestão e acompanhamento.',
        'Transparência nas condições e rendimentos dos títulos.',
        'Incentivo à educação financeira através de materiais educativos.',
      ],
      'image': 'images/tesourodireto.jpg',
      'isExpanded': false,
    },
    {
      'title': 'Fundos Imobiliários (FIIs)',
      'subtitle': 'Receba aluguel mensalmente',
      'description':
          'Os Fundos de Investimento Imobiliário (FIIs) são uma maneira de investir no mercado imobiliário sem precisar comprar ou administrar imóveis diretamente. Eles permitem diversificação em diversos tipos de propriedades, como shoppings, prédios comerciais, galpões logísticos e residenciais. Além disso, muitos FIIs distribuem rendimentos mensais isentos de imposto de renda. Os FIIs oferecem aos investidores a oportunidade de participar do mercado imobiliário com uma parcela menor de capital em comparação à compra direta de imóveis, tornando-se uma alternativa acessível e eficiente para diversificar a carteira de investimentos. A gestão profissional dos fundos garante a otimização dos ativos e a manutenção dos imóveis, reduzindo a carga operacional para os investidores. A liquidez dos FIIs, negociados em bolsa, permite a compra e venda das cotas com facilidade, proporcionando flexibilidade para ajustar a carteira conforme as condições do mercado e os objetivos financeiros pessoais.',
      'topics': [
        'Renda mensal via dividendos.',
        'Diversificação no setor imobiliário.',
        'Riscos: Vacância e desvalorização das cotas.',
        'Negociados em bolsa de valores.',
        'Potencial de valorização das cotas a longo prazo.',
        'Diversos tipos de FIIs: tijolo, papel, híbrido.',
        'Baixa barreira de entrada para investidores.',
        'Gestão profissional dos ativos imobiliários.',
        'Acessibilidade com menores valores de investimento.',
        'Flexibilidade na compra e venda das cotas em bolsa.',
      ],
      'image': 'images/fii.png',
      'isExpanded': false,
    },
    {
      'title': 'Ações',
      'subtitle': 'Investir em empresas',
      'description':
          'Investir em ações significa se tornar sócio de grandes empresas e participar de seus lucros por meio de dividendos ou valorização no mercado. É uma modalidade de investimento com alto potencial de retorno, mas que também envolve maior risco devido à volatilidade do mercado. A análise constante do mercado e das empresas é essencial para alcançar bons resultados. Além disso, o mercado de ações oferece diversas estratégias de investimento, como o investimento em crescimento, valor, dividendos e especulação, permitindo que os investidores escolham a abordagem que melhor se alinha com seus objetivos e perfil de risco. A diversificação em diferentes setores e empresas pode mitigar riscos e potencializar retornos, enquanto a utilização de ferramentas de análise técnica e fundamentalista pode auxiliar na tomada de decisões mais informadas. Participar de assembleias de acionistas e acompanhar as notícias e tendências econômicas também são práticas recomendadas para investidores que desejam maximizar seus ganhos no mercado de ações.',
      'topics': [
        'Potencial de alto retorno no longo prazo.',
        'Alta volatilidade (riscos maiores).',
        'Dividendos geram renda passiva.',
        'Requer análise e acompanhamento constante.',
        'Diversificação através de diferentes setores e empresas.',
        'Possibilidade de operar com day trade e swing trade.',
        'Impacto de fatores macroeconômicos nas cotações.',
        'Estratégias de investimento: crescimento, valor, dividendos.',
        'Uso de análise técnica e fundamentalista.',
        'Participação em assembleias de acionistas.',
      ],
      'image': 'images/acoes.png',
      'isExpanded': false,
    },
    {
      'title': 'Debêntures',
      'subtitle': 'Títulos de dívida corporativa',
      'description':
          'Debêntures são títulos de dívida emitidos por empresas privadas com o objetivo de captar recursos para projetos e expansão. Oferecem taxas de juros atrativas, superiores aos títulos públicos ou bancários, mas não possuem garantia do FGC, tornando-se investimentos de maior risco. Algumas debêntures incentivadas oferecem isenção de imposto de renda. Além disso, as debêntures podem ser estruturadas de diferentes formas, incluindo debêntures conversíveis, que permitem a conversão em ações da empresa emissora, e debêntures permutáveis, que permitem a troca por outros ativos. A escolha de investir em debêntures deve levar em consideração a saúde financeira da empresa emissora, a taxa de retorno oferecida e o prazo de vencimento, bem como a estratégia de investimento do próprio investidor. A análise detalhada do prospecto e dos relatórios financeiros da empresa é essencial para avaliar os riscos e potenciais retornos associados a esse tipo de investimento.',
      'topics': [
        'Sem garantia do FGC.',
        'Ideal para diversificação com maior risco.',
        'Podem oferecer isenção de imposto em algumas categorias.',
        'Variedade de prazos e taxas de remuneração.',
        'Possibilidade de conversão em ações da empresa emissora.',
        'Riscos associados à saúde financeira da empresa emissora.',
        'Debêntures incentivadas voltadas para projetos de infraestrutura.',
        'Estruturação diversificada: conversíveis, permutáveis, etc.',
        'Análise detalhada necessária para avaliação de riscos.',
        'Potencial de retorno superior aos títulos públicos.',
      ],
      'image': 'images/debentures.png',
      'isExpanded': false,
    },
    {
      'title': 'Criptomoedas',
      'subtitle': 'Investimento digital',
      'description':
          'Criptomoedas, como Bitcoin e Ethereum, são moedas digitais baseadas na tecnologia blockchain. Elas oferecem a oportunidade de ganhos elevados, mas são altamente voláteis. Requerem estudo aprofundado do mercado e das tecnologias envolvidas. Apesar do risco, têm atraído investidores em busca de diversificação. Além disso, as criptomoedas possibilitam transações descentralizadas, reduzindo a necessidade de intermediários e proporcionando maior privacidade e segurança nas transações financeiras. A inovação constante no espaço das criptomoedas, com o surgimento de novas moedas e aplicações descentralizadas (dApps), amplia as possibilidades de investimento e utilização dessas tecnologias. No entanto, a falta de regulamentação clara e as flutuações de mercado tornam essencial que os investidores se mantenham informados e adotem práticas de segurança robustas para proteger seus ativos digitais.',
      'topics': [
        'Alta volatilidade e riscos.',
        'Necessário conhecimento sobre blockchain.',
        'Não regulamentado por governos.',
        'Possibilidade de altos retornos em curto prazo.',
        'Diversas opções além do Bitcoin e Ethereum, como altcoins.',
        'Segurança e armazenamento (carteiras digitais).',
        'Impacto de notícias e regulações no mercado.',
        'Transações descentralizadas e sem intermediários.',
        'Inovação contínua com novas moedas e aplicações.',
        'Práticas de segurança essenciais para proteção dos ativos.',
      ],
      'image': 'images/crypto.png',
      'isExpanded': false,
    },
    {
      'title': 'ETFs',
      'subtitle': 'Fundos de Índice',
      'description':
          'Os ETFs (Exchange Traded Funds) são fundos de investimento que replicam índices de mercado, como o Ibovespa. Eles permitem diversificação instantânea em várias ações ou ativos com custos reduzidos. São negociados em bolsa como ações e são indicados tanto para iniciantes quanto para investidores experientes. Além disso, os ETFs oferecem flexibilidade na gestão da carteira, permitindo aos investidores comprar e vender cotas conforme a demanda do mercado durante o pregão, ao contrário dos fundos tradicionais que têm liquidez apenas no final do dia. A variedade de ETFs disponíveis abrange diferentes setores, regiões geográficas e estratégias de investimento, incluindo ETFs de renda fixa, ETFs setoriais, ETFs temáticos e ETFs internacionais. A transparência na composição do fundo e as baixas taxas de administração tornam os ETFs uma opção eficiente para diversificação e gestão passiva de investimentos, alinhando-se com estratégias de longo prazo e redução de custos operacionais.',
      'topics': [
        'Diversificação automática.',
        'Taxas de administração baixas.',
        'Podem ser negociados como ações.',
        'Transparência na composição do fundo.',
        'Facilidade de compra e venda no mercado.',
        'Variedade de ETFs que replicam diferentes setores e regiões.',
        'Possibilidade de investir em ETFs temáticos.',
        'Gestão passiva alinhada a índices de referência.',
        'Flexibilidade na negociação durante o pregão.',
        'Redução de custos operacionais em comparação a fundos tradicionais.',
      ],
      'image': 'images/etfs.png',
      'isExpanded': false,
    },
    {
      'title': 'Poupança',
      'subtitle': 'Investimento tradicional',
      'description':
          'A poupança é uma das opções de investimento mais simples e acessíveis. Embora ofereça alta liquidez e isenção de impostos, seu rendimento frequentemente fica abaixo da inflação, tornando-a menos atrativa em comparação a outras opções do mercado. Contudo, a poupança permanece popular devido à sua facilidade de acesso, sem a necessidade de conhecimentos avançados ou estratégias de investimento. É ideal para investidores que buscam segurança máxima e desejam manter uma reserva de emergência facilmente acessível. Além disso, a poupança pode servir como um ponto de partida para novos investidores que estão começando a explorar o mundo dos investimentos, proporcionando uma introdução prática e sem riscos significativos. Apesar das limitações em termos de rendimento, a simplicidade e a garantia do FGC tornam a poupança uma opção confiável para determinados perfis de investidores.',
      'topics': [
        'Alta liquidez.',
        'Rendimento abaixo da inflação.',
        'Garantido pelo FGC até R\$250 mil.',
        'Facilidade de acesso e simplicidade.',
        'Ideal para reservas de emergência.',
        'Sem necessidade de conhecimentos avançados.',
        'Taxa de rendimento definida por regras governamentais.',
        'Sem custos de administração ou taxas de corretagem.',
        'Disponibilidade em praticamente todas as instituições financeiras.',
        'Transação rápida para depósitos e saques.',
      ],
      'image': 'images/poupanca.png',
      'isExpanded': false,
    },
    {
      'title': 'Previdência Privada',
      'subtitle': 'Planejamento de longo prazo',
      'description':
          'A previdência privada é voltada para planejamento de aposentadoria e longo prazo. Com planos como PGBL e VGBL, oferece benefícios fiscais e flexibilidade de aportes. Ideal para quem busca complementar a aposentadoria oficial. Além disso, a previdência privada permite ao investidor escolher entre diferentes fundos de investimento, adequando a alocação de ativos conforme seu perfil de risco e objetivos financeiros. A diversificação entre renda fixa, renda variável e outros ativos dentro dos planos de previdência contribui para a maximização dos retornos e a mitigação de riscos. A portabilidade entre planos e instituições facilita ajustes na estratégia de investimento ao longo do tempo, garantindo que o plano se mantenha alinhado às necessidades e mudanças na vida do investidor. A possibilidade de resgates programados ou únicos também oferece flexibilidade na utilização dos recursos acumulados, tornando a previdência privada uma ferramenta eficaz para o planejamento financeiro de longo prazo.',
      'topics': [
        'Vantagens fiscais no PGBL.',
        'Ideal para aposentadoria.',
        'Taxas de administração podem ser altas.',
        'Diversidade de fundos e estratégias de investimento.',
        'Portabilidade entre planos e instituições.',
        'Possibilidade de escolher entre renda vitalícia ou prazo determinado.',
        'Benefícios para herdeiros em caso de falecimento.',
        'Flexibilidade nos aportes e resgates.',
        'Alocação diversificada de ativos dentro dos planos.',
        'Adequação ao perfil de risco e objetivos financeiros.',
      ],
      'image': 'images/previdencia.png',
      'isExpanded': false,
    },
    {
      'title': 'Fundos de Investimento',
      'subtitle': 'Gestão profissional',
      'description':
          'Os Fundos de Investimento reúnem recursos de vários investidores para aplicar em uma carteira diversificada de ativos, como ações, títulos públicos, CDBs, entre outros. Gerenciados por profissionais especializados, oferecem a vantagem da diversificação e da gestão ativa, permitindo que investidores com menor conhecimento ou tempo possam participar de mercados complexos. Além disso, os fundos de investimento proporcionam acesso a estratégias avançadas e setores de mercado que podem ser inacessíveis para investidores individuais, como mercados internacionais, derivativos e investimentos alternativos. A gestão profissional também implica em análise constante e reequilíbrio da carteira, visando otimizar os retornos e minimizar os riscos. A transparência e regulamentação pela CVM garantem que os investidores tenham acesso a informações detalhadas sobre a performance e a composição dos fundos, facilitando a tomada de decisões informadas. Com uma ampla gama de fundos disponíveis, os investidores podem selecionar aqueles que melhor se alinham com seus objetivos financeiros, tolerância ao risco e horizonte de investimento.',
      'topics': [
        'Diversificação automática de ativos.',
        'Gestão profissional e especializada.',
        'Diversos tipos: fundos de renda fixa, multimercados, ações, etc.',
        'Taxas de administração e performance.',
        'Liquidez variável conforme o tipo de fundo.',
        'Acesso a mercados e ativos difíceis de investir individualmente.',
        'Transparência e regulamentação pela CVM.',
        'Estratégias de investimento avançadas e diversificadas.',
        'Possibilidade de investir em setores específicos e mercados internacionais.',
        'Gestão ativa visando otimização de retornos e minimização de riscos.',
      ],
      'image': 'images/fundos.png',
      'isExpanded': false,
    },
    {
      'title': 'Opções',
      'subtitle': 'Derivativos de renda variável',
      'description':
          'As opções são contratos que dão ao comprador o direito, mas não a obrigação, de comprar ou vender um ativo por um preço pré-determinado antes ou na data de vencimento. Utilizadas para especulação ou proteção (hedge) de carteiras, as opções são instrumentos financeiros avançados que exigem conhecimento aprofundado do mercado de derivativos. Além disso, as opções permitem a criação de estratégias complexas que podem ser adaptadas para diferentes cenários de mercado, como spreads, straddles e strangles, cada uma com suas próprias características de risco e retorno. A flexibilidade das opções possibilita a alavancagem de posições, permitindo que os investidores potencializem seus ganhos com um capital inicial menor, embora isso também aumente o risco de perdas significativas. A volatilidade implícita das opções desempenha um papel crucial na precificação e nas estratégias de negociação, exigindo que os investidores monitorem constantemente os fatores que influenciam o preço das opções. A educação contínua e a prática são essenciais para dominar o uso eficaz das opções como parte de uma estratégia de investimento abrangente.',
      'topics': [
        'Direito de comprar (call) ou vender (put) ativos.',
        'Alavancagem financeira para potencializar ganhos.',
        'Uso para proteção de carteiras (hedge).',
        'Maior complexidade e risco elevado.',
        'Necessidade de conhecimento técnico avançado.',
        'Possibilidade de estratégias variadas como spreads e straddles.',
        'Impacto das volatilidades implícitas nos preços.',
        'Estratégias de hedge para proteção contra quedas de mercado.',
        'Aproveitamento de movimentos de preço em alta ou baixa.',
        'Análise constante de fatores que influenciam a volatilidade.',
      ],
      'image': 'images/opcoes.png',
      'isExpanded': false,
    },
    {
      'title': 'Commodities',
      'subtitle': 'Investimento em bens físicos',
      'description':
          'Commodities são bens físicos como ouro, prata, petróleo, soja, entre outros, que são negociados em mercados internacionais. Investir em commodities pode servir como proteção contra a inflação e diversificação de portfólio. No entanto, os preços podem ser altamente voláteis e influenciados por fatores geopolíticos e ambientais. Além disso, as commodities oferecem oportunidades de investimento tanto através da compra direta dos bens físicos quanto de instrumentos financeiros como contratos futuros, ETFs de commodities e ações de empresas do setor. A demanda global, os eventos climáticos e as políticas governamentais desempenham papéis significativos na determinação dos preços das commodities, exigindo que os investidores mantenham-se informados sobre as tendências globais e regionais. A alocação estratégica em commodities pode equilibrar a carteira, reduzindo a correlação com ativos tradicionais como ações e títulos, e proporcionando uma camada adicional de proteção contra riscos sistêmicos no mercado financeiro.',
      'topics': [
        'Diversificação do portfólio com ativos físicos.',
        'Proteção contra a inflação.',
        'Alta volatilidade e riscos associados.',
        'Influência de fatores geopolíticos e climáticos.',
        'Investimento direto (compra física) ou indireto (ETCs, futuros).',
        'Liquidez variável dependendo da commodity.',
        'Potencial de retorno em mercados em alta.',
        'Participação em mercados globais e regionais.',
        'Diversas formas de investimento: físicos, futuros, ETFs.',
        'Monitoramento constante de fatores que afetam os preços.',
      ],
      'image': 'images/commodities.png',
      'isExpanded': false,
    },
    {
      'title': 'REITs',
      'subtitle': 'Real Estate Investment Trusts',
      'description':
          'REITs são fundos de investimento imobiliário negociados em bolsa de valores que permitem aos investidores participar do mercado imobiliário sem a necessidade de comprar propriedades físicas. Eles distribuem grande parte de seus lucros como dividendos, proporcionando renda passiva aos investidores. Além disso, os REITs oferecem liquidez semelhante à das ações, permitindo a compra e venda de cotas com facilidade durante o pregão. A diversificação em diferentes tipos de propriedades, como residenciais, comerciais, industriais e de infraestrutura, reduz os riscos associados a um único setor imobiliário. Os REITs também beneficiam-se de estratégias de gestão profissional, que incluem a aquisição, manutenção e valorização dos ativos imobiliários, além de otimizar a distribuição de rendimentos aos investidores. A transparência e regulamentação no mercado de capitais garantem que os investidores tenham acesso a informações detalhadas sobre a performance e a composição dos REITs, facilitando a tomada de decisões informadas e a integração dos REITs em uma carteira de investimentos diversificada.',
      'topics': [
        'Investimento em imóveis através de fundos.',
        'Distribuição regular de dividendos.',
        'Liquidez semelhante à das ações.',
        'Diversificação em diferentes tipos de propriedades.',
        'Transparência e regulamentação no mercado de capitais.',
        'Potencial de valorização das cotas a longo prazo.',
        'Acesso a mercados imobiliários internacionais.',
        'Gestão profissional dos ativos imobiliários.',
        'Facilidade de inclusão em carteiras diversificadas.',
        'Redução de riscos através da diversificação de ativos.',
      ],
      'image': 'images/reits.png',
      'isExpanded': false,
    },
  ];

  void _toggleCard(int index) {
    setState(() {
      _investmentData[index]['isExpanded'] =
          !_investmentData[index]['isExpanded'];
    });
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _investmentData.length,
                itemBuilder: (context, index) {
                  return InvestmentCard(
                    title: _investmentData[index]['title'],
                    subtitle: _investmentData[index]['subtitle'],
                    description: _investmentData[index]['description'],
                    topics: _investmentData[index]['topics'],
                    image: _investmentData[index]['image'],
                    isExpanded: _investmentData[index]['isExpanded'],
                    onTap: () => _toggleCard(index),
                  );
                },
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
              const Text(
                'Saldo: 0.00',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/icon.png'),
            radius: 30,
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Explore o mundo dos investimentos',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

class InvestmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> topics;
  final String image;
  final bool isExpanded;
  final VoidCallback onTap;

  const InvestmentCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.topics,
    required this.image,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF244673),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset(
                  image,
                  width: 80,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.yellow,
                ),
              ),
              if (isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: topics.map((topic) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.yellow, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                topic,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
