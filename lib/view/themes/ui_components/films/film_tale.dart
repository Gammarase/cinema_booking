import 'package:cinema_booking/domain/entities/film.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmTale extends StatelessWidget {
  final Film film;

  const FilmTale({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height / 8,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  film.smallImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(film.year.toString(),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFffca37),
                        ),
                        Text(
                          film.rating,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () => context
                              .read<AppAuthBloc>()
                              .add(AddRemoveFavoriteEvent(filmId: film.id)),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: BlocBuilder<AppAuthBloc, AppState>(
                              builder: (context, state) {
                                return Icon(
                                  Icons.favorite,
                                  color: state.favoriteMovies.contains(film.id)
                                      ? const Color(0xFFFFC145)
                                      : null,
                                  size: 30,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
