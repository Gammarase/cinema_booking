import '../../domain/entities/seats_structure.dart';

class RowModel extends SeatRow {
  RowModel({required super.id, required super.index, required super.seats});

  factory RowModel.fromJson(Map<String, dynamic> json) {
    return RowModel(
        id: json["id"],
        index: json["index"],
        seats: json['seats']
            .map<SeatModel>((json) => SeatModel.fromJson(json))
            .toList());
  }
}

class SeatModel extends Seat {
  SeatModel(
      {required super.id,

      required super.index,
      required super.type,
      required super.price,
      required super.isAvailable});

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
        id: json["id"],
        index: json["index"],
        type: SeatType.values[json['type']],
        price: json["price"],
        isAvailable: json["isAvailable"]);
  }
}
