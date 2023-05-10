import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/pages/films/movie_view_page.dart';
import 'package:cinema_booking/view/pages/films/search_film_page.dart';
import 'package:cinema_booking/view/themes/ui_components/films/film_tale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilmsPage extends StatelessWidget {
  const FilmsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Today`s films',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchFilms(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder(
            future: context
                .read<AppAuthBloc>()
                .state
                .dioClient
                .getFilms(DateFormat('yyyy-MM-dd').format(DateTime.now()), ''),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilmInfo(
                              film: snapshot.data![index],
                              stringDate: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now())),
                        ),
                      ),
                      child: FilmTale(
                        film: snapshot.data![index],
                      ),
                    );
                  },
                  itemCount: snapshot.data?.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    );
  }
}
