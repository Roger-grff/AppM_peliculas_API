import 'package:flutter/material.dart';
import '../services/services.dart';
import 'detail_api_page.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  final TextEditingController controller =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  List<dynamic> series = [];

  int pagina = 0;

  bool cargando = false;
  bool buscando = false;

  @override
  void initState() {
    super.initState();

    cargarSeries();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent -
                  200 &&
          !cargando &&
          !buscando) {
        cargarSeries();
      }
    });
  }

  Future<void> cargarSeries() async {
    setState(() {
      cargando = true;
    });

    try {
      final nuevas =
          await TvMazeService.obtenerSeries(
              pagina);

      nuevas.sort((a, b) {
        return (a['name'] ?? '')
            .toString()
            .toLowerCase()
            .compareTo(
              (b['name'] ?? '')
                  .toString()
                  .toLowerCase(),
            );
      });

      setState(() {
        series.addAll(nuevas);
        pagina++;
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      cargando = false;
    });
  }

  Future<void> buscarSeries() async {
    final texto =
        controller.text.trim();

    if (texto.isEmpty) {
      setState(() {
        buscando = false;
        series.clear();
        pagina = 0;
      });

      cargarSeries();
      return;
    }

    setState(() {
      buscando = true;
      cargando = true;
    });

    try {
      final resultado =
          await TvMazeService.buscarSeries(
              texto);

      resultado.sort((a, b) {
        return (a['name'] ?? '')
            .toString()
            .toLowerCase()
            .compareTo(
              (b['name'] ?? '')
                  .toString()
                  .toLowerCase(),
            );
      });

      setState(() {
        series = resultado;
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      cargando = false;
    });
  }

  Widget imagenSerie(dynamic show) {
    final imagen =
        show['image']?['medium'];

    if (imagen == null) {
      return const Icon(
        Icons.tv,
        size: 50,
      );
    }

    return Image.network(
      imagen,
      width: 60,
      fit: BoxFit.cover,
      errorBuilder:
          (context, error, stackTrace) {
        return const Icon(
          Icons.tv,
          size: 50,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Series TVMaze'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              decoration:
                  InputDecoration(
                labelText:
                    'Buscar serie',
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                suffixIcon:
                    IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  onPressed: () {
                    controller.clear();

                    setState(() {
                      buscando = false;
                      series.clear();
                      pagina = 0;
                    });

                    cargarSeries();
                  },
                ),
                border:
                    const OutlineInputBorder(),
              ),
              onChanged: (value) {
                buscarSeries();
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller:
                  scrollController,
              itemCount:
                  series.length +
                      (cargando &&
                              !buscando
                          ? 1
                          : 0),
              itemBuilder:
                  (context, index) {
                if (index ==
                    series.length) {
                  return const Padding(
                    padding:
                        EdgeInsets.all(
                            20),
                    child: Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                  );
                }

                final show =
                    series[index];

                final nombre =
                    show['name'] ??
                        'Sin nombre';

                final idioma =
                    show['language'] ??
                        'Sin idioma';

                final generos =
                    (show['genres']
                                as List?)
                            ?.join(
                                ', ') ??
                        'Sin género';

                final rating =
                    show['rating']
                            ?['average']
                        ?.toString() ??
                        'N/A';

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading:
                        imagenSerie(
                            show),
                    title:
                        Text(nombre),
                    subtitle:
                        Text(
                      'Idioma: $idioma\n'
                      'Géneros: $generos\n'
                      'Rating: $rating',
                    ),
                    isThreeLine:
                        true,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailApiPage(
                            show: show,
                          ),
                        ),
                      );
                      if(!mounted) return;
                      setState(() {});
                    },
                  ),
                );   
              },
            ),
          ),
        ],
      ),
    );
  }
}