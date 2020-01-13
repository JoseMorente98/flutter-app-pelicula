import 'dart:async';
import 'dart:convert';

import 'package:pelicula/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = '29e4712d4d497f2f21ff85e212c6ec75';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _cargando = false;
  int _popularesPage = 0;
  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast(); 

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesar(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final peliculas = new Peliculas.fromJsonMap(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
    });
    return await _procesar(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    print('Cargando siguientes');
    if(_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page'    : _popularesPage.toString()
    });

    final res = await _procesar(url);
    _populares.addAll(res);
    popularesSink(_populares);
    _cargando = false;

    return res;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'query'    : query
    });
    return await _procesar(url);
  }

}