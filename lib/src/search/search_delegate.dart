import 'package:flutter/material.dart';
import 'package:pelicula/src/models/pelicula_model.dart';
import 'package:pelicula/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculas = [
    'Superman',
    'Dragon Ball',
    'Star Wars',
    'Doraemon',
    'Aquaman',
  ];
  final peliculaProvider = new PeliculaProvider();
  final peliculasRecientes = [
    'Spider Man',
    'Capitan America',
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquieda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados
    /*return Center(
      child: Container(
        height: 10,
      ),
    );*/
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias de busqueda

    if(query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculaProvider.buscarPeliculas(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if(snapshot.hasData) {
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                  image: NetworkImage(pelicula.getPoster()),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover,
                  height: 50.0,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.popAndPushNamed(context, 'detalle', arguments: pelicula);
                },
                );
              }).toList()
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      );
    }
    /*final listaSugerida = (query.isEmpty) ? peliculasRecientes : peliculas.where((p)=>p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );*/
  }

}