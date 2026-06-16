import 'dart:convert';
import 'package:http/http.dart' as http;

class OmdbService {
  static const apiKey = "TU_API_KEY";

  static Future<List<dynamic>> buscarPeliculas(
      String texto, int page) async {

    final url = Uri.parse(
      'https://www.omdbapi.com/?apikey=$apiKey&s=$texto&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["Search"] != null) {
        return data["Search"];
      }

      return [];
    }

    throw Exception("Error al consumir la API");
  }
}