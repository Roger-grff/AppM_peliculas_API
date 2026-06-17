import 'dart:convert';
import 'package:http/http.dart' as http;

class TvMazeService {
  static Future<List<dynamic>> obtenerSeries(int pagina) async {
    final url = Uri.parse(
      'https://api.tvmaze.com/shows?page=$pagina',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Error al obtener series');
  }

  static Future<List<dynamic>> buscarSeries(String texto) async {
    final url = Uri.parse(
      'https://api.tvmaze.com/search/shows?q=$texto',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data.map((e) => e['show']).toList();
    }

    throw Exception('Error al buscar series');
  }
}