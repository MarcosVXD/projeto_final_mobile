import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MarvelInfinityApp());
}

const vermelho = Color(0xFFE62429);
const fundo = Color(0xFF101114);
const card = Color(0xFF1C1E24);

class MarvelInfinityApp extends StatelessWidget {
  const MarvelInfinityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Infinity',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: fundo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: vermelho,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

// SPLASH SCREEN

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  final joias = [
    'assets/images/joia_espaco.png',
    'assets/images/joia_realidade.png',
    'assets/images/joia_alma.png',
    'assets/images/joia_tempo.png',
    'assets/images/joia_poder.png',
    'assets/images/joia_mente.png',
  ];

  final cores = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber,
  ];

  final posicoes = [
    const Offset(256, 32),
    const Offset(371, 84),
    const Offset(370, 263),
    const Offset(256, 292),
    const Offset(143, 263),
    const Offset(142, 84),
  ];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final largura = constraints.maxWidth < 420
                  ? constraints.maxWidth * 0.94
                  : 394.0;
              final escala = largura / 512;
              final altura = 341 * escala;

              return SizedBox(
                width: largura,
                height: altura,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    final progresso = controller.value;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Opacity(
                          opacity: (progresso / 0.18)
                              .clamp(0.0, 1.0)
                              .toDouble(),
                          child: Image.asset(
                            'assets/images/logo_base.png',
                            width: largura,
                            height: altura,
                            fit: BoxFit.fill,
                          ),
                        ),
                        for (int i = 0; i < joias.length; i++)
                          construirJoia(i, progresso, escala),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget construirJoia(int index, double progresso, double escala) {
    final deslocamento =
        posicoes[index] - const Offset(256, 170.5);
    final angulo = progresso * 2 * pi;

    final x = 256 +
        deslocamento.dx * cos(angulo) -
        deslocamento.dy * sin(angulo);

    final y = 170.5 +
        deslocamento.dx * sin(angulo) +
        deslocamento.dy * cos(angulo);

    final opacidade = ((progresso - index * 0.045) / 0.13)
        .clamp(0.0, 1.0)
        .toDouble();

    final tamanho = 64 * escala;

    return Positioned(
      left: x * escala - tamanho / 2,
      top: y * escala - tamanho / 2,
      child: Opacity(
        opacity: opacidade,
        child: Container(
          width: tamanho,
          height: tamanho,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: cores[index].withOpacity(opacidade * 0.65),
                blurRadius: 18 * escala,
                spreadRadius: 3 * escala,
              ),
            ],
          ),
          child: Image.asset(joias[index], fit: BoxFit.contain),
        ),
      ),
    );
  }
}

// MODELOS

class Filme {
  final String nome, ano, data, duracao, sinopse, poster;
  final List<Ator> elenco;

  const Filme({
    required this.nome,
    required this.ano,
    required this.data,
    required this.duracao,
    required this.sinopse,
    required this.poster,
    required this.elenco,
  });
}

class Ator {
  final String nome, personagem, foto;

  const Ator({
    required this.nome,
    required this.personagem,
    required this.foto,
  });
}

// CATÁLOGO

final List<Filme> filmes = [
  Filme(
    nome: 'Homem de Ferro',
    ano: '2008',
    data: '30 de abril de 2008',
    duracao: '2h 06min',
    poster: 'https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg',
    sinopse: 'Tony Stark, um bilionário e inventor genial, é capturado por terroristas. Durante o cativeiro, constrói uma armadura de alta tecnologia e consegue escapar. Ao retornar para casa, decide usar sua criação para proteger o mundo como Homem de Ferro.',
    elenco: [
      Ator(nome: 'Robert Downey Jr.', personagem: 'Tony Stark / Homem de Ferro', foto: 'https://image.tmdb.org/t/p/w185/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
      Ator(nome: 'Gwyneth Paltrow', personagem: 'Pepper Potts', foto: 'https://image.tmdb.org/t/p/w185/tDq8F8z4Qx5K7m3K8v1.jpg'),
      Ator(nome: 'Jeff Bridges', personagem: 'Obadiah Stane', foto: 'https://image.tmdb.org/t/p/w185/4zV0fV0.jpg'),
    ],
  ),
  Filme(
    nome: 'Homem de Ferro 2',
    ano: '2010',
    data: '30 de abril de 2010',
    duracao: '2h 04min',
    poster: 'https://image.tmdb.org/t/p/w500/6WBeq4fCfn7AN0o21W9qNcRF2l9.jpg',
    sinopse: 'Tony Stark enfrenta as consequências de revelar sua identidade como Homem de Ferro. Enquanto isso, um novo inimigo surge buscando vingança contra sua família.',
    elenco: [
      Ator(nome: 'Robert Downey Jr.', personagem: 'Tony Stark', foto: 'https://image.tmdb.org/t/p/w185/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
      Ator(nome: 'Scarlett Johansson', personagem: 'Natasha Romanoff', foto: 'https://image.tmdb.org/t/p/w185/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg'),
      Ator(nome: 'Don Cheadle', personagem: 'James Rhodes', foto: 'https://image.tmdb.org/t/p/w185/6f3b.jpg'),
    ],
  ),
  Filme(
    nome: 'Capitão América: O Primeiro Vingador',
    ano: '2011',
    data: '29 de julho de 2011',
    duracao: '2h 04min',
    poster: 'https://image.tmdb.org/t/p/w500/vSNxAJTlD0r02V9sPYpOjqDZXUK.jpg',
    sinopse: 'Steve Rogers é um jovem que deseja servir ao seu país durante a Segunda Guerra Mundial. Após participar de um experimento, transforma-se no Capitão América e enfrenta a organização Hydra.',
    elenco: [
      Ator(nome: 'Chris Evans', personagem: 'Steve Rogers / Capitão América', foto: 'https://image.tmdb.org/t/p/w185/3bOGNsHlrswhyW79uvIHH1V43JI.jpg'),
      Ator(nome: 'Hayley Atwell', personagem: 'Peggy Carter', foto: 'https://image.tmdb.org/t/p/w185/v7jK3w.jpg'),
      Ator(nome: 'Sebastian Stan', personagem: 'Bucky Barnes', foto: 'https://image.tmdb.org/t/p/w185/7bWj4B.jpg'),
    ],
  ),
  Filme(
    nome: 'Os Vingadores',
    ano: '2012',
    data: '27 de abril de 2012',
    duracao: '2h 23min',
    poster: 'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    sinopse: 'Quando uma ameaça coloca a Terra em perigo, Nick Fury reúne um grupo de heróis. Homem de Ferro, Capitão América, Thor, Hulk, Viúva Negra e Gavião Arqueiro precisam trabalhar juntos.',
    elenco: [
      Ator(nome: 'Robert Downey Jr.', personagem: 'Tony Stark', foto: 'https://image.tmdb.org/t/p/w185/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
      Ator(nome: 'Chris Evans', personagem: 'Steve Rogers', foto: 'https://image.tmdb.org/t/p/w185/3bOGNsHlrswhyW79uvIHH1V43JI.jpg'),
      Ator(nome: 'Chris Hemsworth', personagem: 'Thor', foto: 'https://image.tmdb.org/t/p/w185/piQGdoIQOF3C1EI5cbYZLAW1gfj.jpg'),
      Ator(nome: 'Mark Ruffalo', personagem: 'Bruce Banner / Hulk', foto: 'https://image.tmdb.org/t/p/w185/z3dvKqMNDQWk3QLxzumloQVR0pv.jpg'),
      Ator(nome: 'Scarlett Johansson', personagem: 'Natasha Romanoff', foto: 'https://image.tmdb.org/t/p/w185/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg'),
    ],
  ),
  Filme(
    nome: 'Guardiões da Galáxia',
    ano: '2014',
    data: '31 de julho de 2014',
    duracao: '2h 01min',
    poster: 'https://image.tmdb.org/t/p/w500/r7vmZjiyZw9rpJMQJdXpjgiCOk9.jpg',
    sinopse: 'Peter Quill se une a um grupo de criminosos intergalácticos para proteger uma poderosa esfera. Juntos, eles formam os Guardiões da Galáxia.',
    elenco: [
      Ator(nome: 'Chris Pratt', personagem: 'Peter Quill / Senhor das Estrelas', foto: 'https://image.tmdb.org/t/p/w185/83o3koL82jt30EJ0rz4Bnzrt2dd.jpg'),
      Ator(nome: 'Zoe Saldaña', personagem: 'Gamora', foto: 'https://image.tmdb.org/t/p/w185/vQBwmsSOAd0JDaEcZ5p43J9xzs9.jpg'),
      Ator(nome: 'Dave Bautista', personagem: 'Drax', foto: 'https://image.tmdb.org/t/p/w185/7pB6e.jpg'),
    ],
  ),
  Filme(
    nome: 'Vingadores: Era de Ultron',
    ano: '2015',
    data: '23 de abril de 2015',
    duracao: '2h 21min',
    poster: 'https://image.tmdb.org/t/p/w500/4ssDuvEDkSArWEdyBl2X5EHvYKU.jpg',
    sinopse: 'Os Vingadores enfrentam Ultron, uma inteligência artificial criada para proteger a humanidade, mas que passa a enxergar os próprios humanos como a maior ameaça.',
    elenco: [
      Ator(nome: 'Robert Downey Jr.', personagem: 'Tony Stark', foto: 'https://image.tmdb.org/t/p/w185/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
      Ator(nome: 'Elizabeth Olsen', personagem: 'Wanda Maximoff', foto: 'https://image.tmdb.org/t/p/w185/wIU675y4dofIDVuhaNWPizJNtep.jpg'),
      Ator(nome: 'Aaron Taylor-Johnson', personagem: 'Pietro Maximoff', foto: 'https://image.tmdb.org/t/p/w185/5o5b.jpg'),
    ],
  ),
];

// HOME

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pesquisa = '';

  @override
  Widget build(BuildContext context) {
    final lista = filmes.where((f) =>
        f.nome.toLowerCase().contains(pesquisa.toLowerCase())).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 18, 14),
              decoration: const BoxDecoration(
                color: vermelho,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 76,
                    height: 54,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MARVEL INFINITY',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'SEU CATÁLOGO DO UNIVERSO MARVEL',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
              child: TextField(
                onChanged: (valor) => setState(() => pesquisa = valor),
                decoration: InputDecoration(
                  hintText: 'Buscar filme...',
                  prefixIcon: const Icon(Icons.search, color: vermelho),
                  filled: true,
                  fillColor: card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 19,
                    decoration: BoxDecoration(
                      color: vermelho,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Text(
                    'FILMES',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text('${lista.length} títulos',
                      style: const TextStyle(color: Colors.white54)),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final colunas = constraints.maxWidth >= 900
                      ? 6
                      : constraints.maxWidth >= 650
                          ? 5
                          : constraints.maxWidth >= 450
                              ? 4
                              : 3;

                  if (lista.isEmpty) {
                    return const Center(
                      child: Text('Nenhum filme encontrado.'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 2, 14, 20),
                    itemCount: lista.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colunas,
                      childAspectRatio: 0.58,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      final filme = lista[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MovieDetailsScreen(filme: filme),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Image.network(
                                  filme.poster,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: card,
                                    child: const Center(
                                      child: Icon(
                                        Icons.movie_outlined,
                                        size: 32,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              filme.nome,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11.5,
                              ),
                            ),
                            Text(
                              filme.ano,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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

// DETALHES E X-RAY

class MovieDetailsScreen extends StatelessWidget {
  final Filme filme;

  const MovieDetailsScreen({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: cabecalho(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tituloSecao('SINOPSE'),
                  const SizedBox(height: 12),
                  Text(
                    filme.sinopse,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 28),
                  elenco(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cabecalho(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            filme.poster,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: card),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.62),
                  Colors.black.withOpacity(0.18),
                  fundo.withOpacity(0.98),
                ],
                stops: const [0, 0.42, 1],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MARVEL STUDIOS',
                  style: TextStyle(
                    color: vermelho,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  filme.nome,
                  style: const TextStyle(
                    fontSize: 27,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 12)],
                  ),
                ),
                const SizedBox(height: 13),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    etiqueta(Icons.calendar_month, filme.ano),
                    etiqueta(Icons.event, filme.data),
                    etiqueta(Icons.schedule, filme.duracao),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tituloSecao(String titulo) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: vermelho,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget etiqueta(IconData icone, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.48),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, color: Colors.white70, size: 13),
          const SizedBox(width: 5),
          Text(texto, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Widget elenco() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tituloSecao('X-RAY'),
          const SizedBox(height: 5),
          const Text(
            'Conheça quem interpreta cada personagem',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 16),
          ...filme.elenco.map(linhaAtor),
        ],
      ),
    );
  }

  Widget linhaAtor(Ator ator) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFF272A32),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              ator.foto,
              width: 58,
              height: 68,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 58,
                height: 68,
                color: const Color(0xFF383B44),
                child: const Icon(Icons.person, color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ator.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'PERSONAGEM',
                  style: TextStyle(
                    color: vermelho,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ator.personagem,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white30),
        ],
      ),
    );
  }
}