import '../../domain/entities/film.dart';

class FilmModel extends Film {
  FilmModel({required super.id,
    required super.name,
    required super.age,
    required super.trailer,
    required super.image,
    required super.smallImage,
    required super.originalName,
    required super.duration,
    required super.language,
    required super.rating,
    required super.year,
    required super.country,
    required super.genre,
    required super.plot,
    required super.starring,
    required super.director,
    required super.screenwriter,
    required super.studio});

  factory FilmModel.fromJson(Map<String, dynamic> json){
    return FilmModel(id: json['id'],
        name: json['name'],
        age: json['age'],
        trailer: json['trailer'],
        image: json['image'],
        smallImage: json['smallImage'],
        originalName: json['originalName'],
        duration: json['duration'],
        language: json['language'],
        rating: json['rating'],
        year: json['year'],
        country: json['country'],
        genre: json['genre'],
        plot: json['plot'],
        starring: json['starring'],
        director: json['director'],
        screenwriter: json['screenwriter'],
        studio: json['studio']);
  }


}
