import 'package:cinema_booking/domain/entities/film.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/pages/films/movie_view_page.dart';
import 'package:cinema_booking/view/themes/film_tale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FavoriteFilms extends StatelessWidget {
  const FavoriteFilms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Favorite films',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<AppAuthBloc, AppState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.favoriteMovies.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: context
                              .read<AppAuthBloc>()
                              .state
                              .dioClient
                              .getFilmById(state.favoriteMovies[index]),
                          builder: (BuildContext context,
                              AsyncSnapshot<Film> snapshot) {
                            if (snapshot.hasData) {
                              return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => FilmInfo(
                                            film: snapshot.data!,
                                            stringDate: DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now()),
                                          ),
                                        ),
                                      ),
                                  child: FilmTale(film: snapshot.data!));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
