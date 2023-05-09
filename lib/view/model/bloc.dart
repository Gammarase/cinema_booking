import 'dart:convert';

import 'package:cinema_booking/data/datasource/app_datasource.dart';
import 'package:cinema_booking/domain/repository/token_storage.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppAuthBloc extends Bloc<AppEvent, AppState> {
  AppAuthBloc()
      : super(
          InitialState(
            tokenInfo: TokenStorage(),
            dioClient: DataSource(),
            lightTheme: false,
          ),
        ) {
    on<Authorization>(_authorization);
    on<AddSeatEvent>(_addingSeat);
    on<ClearSeatsEvent>(_clearSeats);
    on<RemoveSeatEvent>(_removeSeat);
    on<ChangeThemeEvent>(_changeTheme);
    on<AddRemoveFavoriteEvent>(_addRemoveFavorite);
    on<RefreshEvent>(_refresh);
  }

  _authorization(Authorization event, Emitter<AppState> emit) async {
    var instance = await SharedPreferences.getInstance();
    bool lightTheme = instance.getBool('lightTheme') ?? false;
    List<int> favoriteFilms =
        json.decode(instance.getString('favoriteMovies') ?? '[]').cast<int>();
    try {
      await state.tokenInfo.authorize();
    } catch (e) {
      emit(
        AuthorisationFailedState(
          lightTheme: lightTheme,
          tokenInfo: state.tokenInfo,
          dioClient: state.dioClient,
          errorInfo: e.toString(),
        ),
      );
      return;
    }
    emit(
      AuthorisedState(
          favoriteMovies: favoriteFilms,
          tokenInfo: state.tokenInfo,
          dioClient: state.dioClient,
          lightTheme: lightTheme),
    );
  }

  _addingSeat(AddSeatEvent event, Emitter<AppState> emit) {
    state.reservedSeats.add(event.seat);
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
        reservedSeats: state.reservedSeats,
      ),
    );
  }

  _removeSeat(RemoveSeatEvent event, Emitter<AppState> emit) {
    state.reservedSeats.remove(event.seat);
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
        reservedSeats: state.reservedSeats,
      ),
    );
  }

  _clearSeats(ClearSeatsEvent event, Emitter<AppState> emit) {
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
      ),
    );
  }

  _changeTheme(ChangeThemeEvent event, Emitter<AppState> emit) {
    state.lightTheme = state.lightTheme ? false : true;

    SharedPreferences.getInstance()
        .then((inst) => inst.setBool('lightTheme', state.lightTheme));
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
      ),
    );
  }

  _addRemoveFavorite(AddRemoveFavoriteEvent event, Emitter<AppState> emit) {
    state.favoriteMovies.contains(event.filmId)
        ? state.favoriteMovies.remove(event.filmId)
        : state.favoriteMovies.add(event.filmId);

    SharedPreferences.getInstance().then(
      (inst) => inst.setString(
        'favoriteMovies',
        json.encode(state.favoriteMovies),
      ),
    );
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
      ),
    );
  }

  _refresh(RefreshEvent event, Emitter<AppState> emit) {
    emit(
      AuthorisedState(
        favoriteMovies: state.favoriteMovies,
        lightTheme: state.lightTheme,
        tokenInfo: state.tokenInfo,
        dioClient: state.dioClient,
      ),
    );
  }
}
