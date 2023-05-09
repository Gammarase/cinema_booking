import 'package:cinema_booking/domain/entities/seats_structure.dart';
import 'package:intl/intl.dart';

class FilmSession {
  int id;
  int date;
  String type;
  int minPrice;
  Room room;

  FilmSession({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  String get stringDate {
    return DateFormat('dd-MM-yyyy HH:mm').format(
      DateTime.fromMillisecondsSinceEpoch(date * 1000),
    );
  }
}

class Room {
  int id;
  String name;
  List<SeatRow> rows;

  Room({required this.id, required this.name, required this.rows});
}
