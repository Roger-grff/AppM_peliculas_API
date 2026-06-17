import 'package:flutter/material.dart';

import '../db/mongo_database.dart';
import '../models/peliculas.dart';
import 'detail_page.dart';
import 'form_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pelicula>> peliculasFuture;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
  peliculasFuture = MongoDatabase.getPeliculas();
}

  Future<void> refrescar() async {
    setState(() {
      cargarDatos();
    });
  }

  Future<void> eliminar(String id) async {
    await MongoDatabase.deletePelicula(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro eliminado'),
      ),
    );

    await refrescar();
  }

  void confirmarEliminar(Pelicula item) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text('¿Eliminar ${item.titulo}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                if (item.id != null) {
                  eliminar(item.id!);
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> abrirFormulario({Pelicula? pelicula}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPage(pelicula: pelicula),
      ),
    );

    await refrescar();
  }

  void abrirDetalle(Pelicula pelicula) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(pelicula: pelicula),
      ),
    );
  }

  Widget imagenPelicula(String poster) {
  if (poster.isEmpty) {
    return const Icon(
      Icons.movie,
      size: 50,
    );
  }

  return Image.network(
    poster,
    width: 60,
    height: 60,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.broken_image,
        size: 50,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Mis favoritos'),
  actions: [
    IconButton(
      onPressed: refrescar,
      icon: const Icon(Icons.refresh),
    ),
  ],
),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () => abrirFormulario(),
        child: const Icon(Icons.add),
      ), */
      body: FutureBuilder<List<Pelicula>>(
        future: peliculasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error al cargar datos:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final List<Pelicula> data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text('No hay películas registradas'),
            );
          }

          return RefreshIndicator(
            onRefresh: refrescar,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Pelicula item = data[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: imagenPelicula(item.poster),
                    title: Text(item.titulo),
                    subtitle: Text(
                      '${item.genero} | Año: ${item.anio} | Calificación: ${item.calificacion}',
                    ),
                    onTap: () => abrirDetalle(item),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Editar',
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            abrirFormulario(pelicula: item);
                          },
                        ),
                        IconButton(
                          tooltip: 'Eliminar',
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            if (item.id != null) {
                              eliminar(item.id!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}