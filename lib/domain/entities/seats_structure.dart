enum SeatType { normal, better, vip }

class SeatRow {
  int id;
  int index;
  List<Seat> seats;

  SeatRow({required this.id, required this.index, required this.seats});
}

class Seat {
  int id;
  int index;
  SeatType type;
  int price;
  bool isAvailable;

  Seat(
      {required this.id,
      required this.index,
      required this.type,
      required this.price,
      required this.isAvailable});
}
