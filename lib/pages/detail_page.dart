import 'package:flutter/material.dart';
import '../models/peliculas.dart';

class DetailPage extends StatelessWidget {
  final Pelicula pelicula;

  const DetailPage({
    super.key,
    required this.pelicula,
  });

  Widget imagenDetalle() {
    if (pelicula.poster.isEmpty) {
      return const Icon(
        Icons.movie,
        size: 120,
      );
    }

    return Image.network(
      pelicula.poster,
      height: 220,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return const Icon(
          Icons.broken_image,
          size: 120,
        );
      },
    );
  }

  Widget fila(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(valor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pelicula.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imagenDetalle(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pelicula.titulo,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),

                      fila('Género', pelicula.genero),
                      fila('Director', pelicula.director),
                      fila('Año', pelicula.anio.toString()),
                      fila(
                        'Calificación',
                        pelicula.calificacion.toString(),
                      ),
                      fila('Fuente', pelicula.fuente),
                      fila('Descripción', pelicula.descripcion),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}