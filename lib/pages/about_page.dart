import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Widget seccionTitulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acerca del Proyecto',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            seccionTitulo(
              '👥 Integrantes',
            ),

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: Text(
                  'Roger Grefa',
                ),
                subtitle: Text(
                  'Desarrollo de Software',
                ),
              ),
            ),

            seccionTitulo(
              '🌐 API Utilizada',
            ),

            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'Se utilizó la API pública TVMaze '
                  '(https://api.tvmaze.com) para '
                  'consultar información de series '
                  'de televisión, incluyendo nombre, '
                  'géneros, rating, imágenes, estado '
                  'y descripción.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            seccionTitulo(
              '💻 Explicación Técnica',
            ),

            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'La aplicación fue desarrollada '
                  'en Flutter utilizando una '
                  'arquitectura basada en páginas '
                  '(HomePage, ApiPage, DetailPage '
                  'y FormPage).\n\n'
                  'Se implementó un CRUD conectado '
                  'a MongoDB Atlas para almacenar '
                  'películas y series favoritas.\n\n'
                  'La API TVMaze se consume mediante '
                  'el paquete http para obtener '
                  'series y realizar búsquedas.\n\n'
                  'Se implementó navegación entre '
                  'pantallas, scroll infinito, '
                  'almacenamiento en MongoDB y '
                  'visualización detallada de '
                  'cada serie.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            seccionTitulo(
              '📸 Capturas',
            ),

            const Text(
              'Capturas de pantalla de las principales ',
            ),

            const SizedBox(
              height: 15,
            ),

            seccionTitulo(
              'favoritos de la Api guardadas en MongoDB',
            ),
            Image.asset(
              'assets/images/home.png',
              errorBuilder:
                  (context, error,
                      stackTrace) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                            30),
                    child: Center(
                      child: Text(
                        'Captura HomePage',
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            seccionTitulo('consumo de la API'),

            Image.asset(
              'assets/images/api.png',
              errorBuilder:
                  (context, error,
                      stackTrace) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                            30),
                    child: Center(
                      child: Text(
                        'Captura ApiPage',
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),

            seccionTitulo('Detalle de la API'),

            Image.asset(
              'assets/images/api_about.png',
              errorBuilder:
                  (context, error,
                      stackTrace) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                            30),
                    child: Center(
                      child: Text(
                        'Captura ApiDetailPage',
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ), 

            seccionTitulo('Detalle de la serie en MongoDB'),

            Image.asset(
              'assets/images/detail.png',
              errorBuilder:
                  (context, error,
                      stackTrace) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                            30),
                    child: Center(
                      child: Text(
                        'Captura DetailPage',
                      ),
                    ),
                  ),
                );
              },
            ),

            seccionTitulo('Registro de la serie en MongoDB Atlas'),

            Image.asset(
              'assets/images/image.png',
              errorBuilder:
                  (context, error,
                      stackTrace) {
                return const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                            30),
                    child: Center(
                      child: Text(
                        'Captura MongoDB Atlas',
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}