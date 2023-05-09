import 'package:cinema_booking/data/models/seats_structure_models.dart';

import '../../domain/entities/films_session.dart';

class FilmSessionModel extends FilmSession {
  FilmSessionModel({
    required super.id,
    required super.date,
    required super.type,
    required super.minPrice,
    required super.room,
  });

  factory FilmSessionModel.fromJson(Map<String, dynamic> json) {
    return FilmSessionModel(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      minPrice: json['minPrice'],
      room: RoomModel.fromJson( json['room']),
    );
  }
}

class RoomModel extends Room {
  RoomModel({required super.id, required super.name, required super.rows});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        id: json['id'],
        name: json['name'],
        rows: json['rows']
            .map<RowModel>((json) => RowModel.fromJson(json))
            .toList());
  }
}
