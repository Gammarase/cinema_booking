import 'package:cinema_booking/domain/entities/seats_structure.dart';

abstract class AppEvent {}

class Authorization extends AppEvent {}

class AddSeatEvent extends AppEvent {
  AddSeatEvent({required this.seat});

  Seat seat;
}

class RemoveSeatEvent extends AppEvent {
  RemoveSeatEvent({required this.seat});

  Seat seat;
}

class ClearSeatsEvent extends AppEvent {}

class ChangeThemeEvent extends AppEvent {}

class AddRemoveFavoriteEvent extends AppEvent {
  int filmId;

  AddRemoveFavoriteEvent({required this.filmId});
}

class RefreshEvent extends AppEvent{}
