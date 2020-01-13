import 'package:flutter/material.dart';
import 'package:pelicula/src/providers/pelicula_provider.dart';
import 'package:pelicula/src/search/search_delegate.dart';
import 'package:pelicula/src/widgets/card_swiper_widget.dart';
import 'package:pelicula/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final peliculaProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {

    peliculaProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text("PELICULAS"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch()
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            SizedBox(
              height: 5.0,
            ),
            _footer(context)
          ],
        ),
      )
      /*SafeArea(
        child: Text('data'),
      ),*/
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculaProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return CardSwiperWidget(
            peliculas: snapshot.data
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          StreamBuilder(
            stream: peliculaProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                print(snapshot.data);
                return MovieHorizontalWidget(
                  peliculas: snapshot.data,
                  siguientePagina: peliculaProvider.getPopulares,
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                );
              }
            },
          ),
        ],
      ),
    );
  }
}