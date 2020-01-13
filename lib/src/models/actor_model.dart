class Actores {
  List<Actor> items = new List();

  Actores();

  Actores.fromJsonMap( List<dynamic> json) {
    if(json == null) return;
    for (var item in json) {
      final actor = new Actor.fromJsonMap(item);
      items.add(actor);
    }
  }

}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getProfile() {
    if(profilePath == null) {
      return 'https://logodix.com/logo/1070509.png';
    }
    return 'https://image.tmdb.org/t/p/original/$profilePath';
  }
}
