import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../db/mongo_database.dart';
import '../models/peliculas.dart';

class DetailApiPage extends StatelessWidget {
  final dynamic show;

  const DetailApiPage({
    super.key,
    required this.show,
  });

  Future<void> guardarSerie(
    BuildContext context,
  ) async {
  try {

    final peliculas =
      await MongoDatabase.getPeliculas();

    final existe = peliculas.any(
      (p) =>
          p.titulo.toLowerCase() ==
          (show['name'] ?? '')
              .toString()
              .toLowerCase(),
    );

    if (existe) {
      throw Exception(
        'La serie ya está guardada',
      );
    }

    final generos =
        (show['genres'] as List?)
                ?.join(', ') ??
            'Sin género';

    final anio =
        int.tryParse(
          (show['premiered'] ?? '')
              .toString()
              .split('-')
              .first,
        ) ??
        0;

    final rating =
        (show['rating']?['average']
                as num?)
            ?.toDouble() ??
        0;

    final poster =
        show['image']?['original'] ??
            show['image']?['medium'] ??
            '';

    final descripcion =
        (show['summary'] ??
                'Sin descripción')
            .toString()
            .replaceAll(
              RegExp(r'<[^>]*>'),
              '',
            );

    final pelicula = Pelicula(
      id: const Uuid().v4(),
      titulo: show['name'] ??
          'Sin nombre',
      genero: generos,
      director:
          'No disponible',
      anio: anio,
      calificacion:
          rating,
      poster: poster,
      descripcion:
          descripcion,
      fuente: 'TVMaze',
    );

    await MongoDatabase.insertPelicula(pelicula,);

    if (!context.mounted)return;

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Serie guardada correctamente',
        ),
      ),
    );

    Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) {
        return;
      }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $e',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final nombre = show['name'] ?? 'Sin nombre';

    final imagen = show['image']?['original'] ??
        show['image']?['medium'];

    final idioma = show['language'] ?? 'No disponible';

    final generos =
        (show['genres'] as List?)
                ?.join(', ') ??
            'No disponible';

    final rating =
        show['rating']?['average']
                ?.toString() ??
            'N/A';

    final estado =
        show['status'] ?? 'No disponible';

    final estreno =
        show['premiered'] ??
            'No disponible';

    final resumen = (show['summary'] ??
            'Sin descripción')
        .toString()
        .replaceAll(
            RegExp(r'<[^>]*>'), '');

    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        actions: [
          IconButton(
            icon:
                const Icon(
              Icons.bookmark_add,
            ),
            tooltip:
                'Guardar',
            onPressed: () {
              guardarSerie(
                context,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            if (imagen != null)
              Image.network(
                imagen,
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error,
                        stackTrace) {
                  return const SizedBox(
                    height: 350,
                    child: Center(
                      child:
                          Icon(
                        Icons.tv,
                        size: 100,
                      ),
                    ),
                  );
                },
              )
            else
              const SizedBox(
                height: 350,
                child: Center(
                  child: Icon(
                    Icons.tv,
                    size: 100,
                  ),
                ),
              ),

            Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    nombre,
                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  Text(
                    'Idioma: $idioma',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    'Géneros: $generos',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    'Rating: $rating',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    'Estado: $estado',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    'Estreno: $estreno',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  const Text(
                    'Resumen',
                    style:
                        TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    resumen,
                    style:
                        const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}