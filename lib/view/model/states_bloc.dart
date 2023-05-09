import 'package:cinema_booking/data/datasource/app_datasource.dart';
import 'package:cinema_booking/domain/entities/seats_structure.dart';
import 'package:cinema_booking/domain/repository/token_storage.dart';
import 'package:get_it/get_it.dart';

abstract class AppState {
  bool lightTheme;
  TokenStorage tokenInfo;
  DataSource dioClient;
  List<int> favoriteMovies;
  List<Seat> reservedSeats;

  AppState(
      {required this.tokenInfo,
      required this.dioClient,
      required this.lightTheme,
      List<Seat>? reservedSeats,
      List<int>? favoriteMovies})
      : reservedSeats = reservedSeats ?? <Seat>[],
        favoriteMovies = favoriteMovies ?? <int>[];
}

class InitialState extends AppState {
  InitialState(
      {required super.tokenInfo,
      required super.dioClient,
      required super.lightTheme}) {
    final getIt = GetIt.instance;
    //getIt.registerSingleton<TokenStorage>(tokenInfo);
    getIt.registerSingleton<DataSource>(dioClient);
  }
}

class AuthorisedState extends AppState {
  AuthorisedState(
      {required super.tokenInfo,
      required super.dioClient,
      super.reservedSeats,
      super.favoriteMovies,
      required super.lightTheme});
}

class AuthorisationFailedState extends AppState {
  String errorInfo;

  AuthorisationFailedState(
      {required super.tokenInfo,
      required super.dioClient,
      required this.errorInfo,
      required super.lightTheme});
}
