import 'dart:convert';

import 'package:pelicula/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = '29e4712d4d497f2f21ff85e212c6ec75';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
    });
    final res = await http.get(url);
    final decodedData = json.decode(res.body);
    print(decodedData);

    final peliculas = new Peliculas.fromJsonMap(decodedData['results']);
    print(peliculas.items[0].title);
    print(peliculas.items[1].title);
    print(peliculas.items[2].title);
    print(peliculas.items[3].title);
    print(peliculas.items[4].title);
    return peliculas.items;
  }

}