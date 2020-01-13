import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pelicula/src/models/actor_model.dart';

class ActorProvider {
  String _apiKey = '29e4712d4d497f2f21ff85e212c6ec75';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getActores(String id) async {
    final url = Uri.https(_url, '3/movie/$id/credits', {
      'api_key' : _apiKey,
      'language' : _language,
    });
    return await _procesar(url);
  }

  Future<List<Actor>> _procesar(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final resp = new Actores.fromJsonMap(decodedData['cast']);
    return resp.items;
  }

}