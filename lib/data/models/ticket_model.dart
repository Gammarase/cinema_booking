import 'package:cinema_booking/domain/entities/ticket.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.id,
    required super.movieId,
    required super.name,
    required super.date,
    required super.image,
    required super.smallImage,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['id'],
        movieId: json['movieId'],
        name: json['name'],
        date: json['date'],
        image: json['image'],
        smallImage: json['smallImage']);
  }
}
