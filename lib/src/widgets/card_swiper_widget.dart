import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelicula/src/models/pelicula_model.dart';

class CardSwiperWidget extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiperWidget( {
    @required
    this.peliculas
  });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].getPoster()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover
            ));
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
          layout: SwiperLayout.STACK,
        ),
    );
  }
}