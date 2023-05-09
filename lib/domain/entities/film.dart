class Film {
  int id;
  String name;
  int age;
  String trailer;
  String image;
  String smallImage;
  String originalName;
  int duration;
  String language;
  String rating;
  int year;
  String country;
  String genre;
  String plot;
  String starring;
  String director;
  String screenwriter;
  String studio;

  Film({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });

  get stringDuration{
    int hours = duration~/60;
    int minutes = duration%60;
    return "${hours}h${minutes}m";
  }
}
