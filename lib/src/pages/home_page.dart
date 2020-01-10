import 'package:flutter/material.dart';
import 'package:pelicula/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PELICULAS"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ],
        ),
      )
      /*SafeArea(
        child: Text('data'),
      ),*/
    );
  }

  _swiperTarjetas() {
    return CardSwiperWidget(
      peliculas: [1,2,3,4,5],
    );
  }
}