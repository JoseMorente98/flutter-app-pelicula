class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonMap( List<dynamic> json) {
    if(json == null) return;
    for (var item in json) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }

}

class Pelicula {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  getPoster() {
    if(posterPath == null) {
      return 'https://www.samsung.com/etc/designs/smg/global/imgs/support/cont/NO_IMG_600x600.png';
    }
    return 'https://image.tmdb.org/t/p/original/$posterPath';
  }

  getBackdropPath() {
    if(backdropPath == null) {
      return 'https://www.samsung.com/etc/designs/smg/global/imgs/support/cont/NO_IMG_600x600.png';
    }
    return 'https://image.tmdb.org/t/p/original/$backdropPath';
  }

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    popularity       = json['popularity'] / 1;
    voteCount        = json['vote_count'];
    video            = json['video'];
    posterPath       = json['poster_path'];
    id               = json['id'];
    adult            = json['adult'];
    backdropPath     = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    title            = json['title'];
    voteAverage      = json['vote_average'] / 1;
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }
}
