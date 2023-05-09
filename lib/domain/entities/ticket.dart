import 'package:intl/intl.dart';

class Ticket {
  int id;
  int movieId;
  String name;
  int date;
  String image;
  String smallImage;

  Ticket({
    required this.id,
    required this.movieId,
    required this.name,
    required this.date,
    required this.image,
    required this.smallImage,
  });

  String get stringDate {
    return DateFormat('dd-MM-yyyy HH:mm').format(
      DateTime.fromMillisecondsSinceEpoch(date * 1000),
    );
  }
}
