import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/themes/ui_components/films/film_tale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'movie_view_page.dart';

class SearchFilms extends StatefulWidget {
  const SearchFilms({Key? key}) : super(key: key);

  @override
  State<SearchFilms> createState() => _SearchFilmsState();
}

class _SearchFilmsState extends State<SearchFilms> {
  late TextEditingController _searchLine;
  late TextEditingController _date;
  final _today = DateTime.now();

  @override
  void initState() {
    _searchLine = TextEditingController();
    _date =
        TextEditingController(text: DateFormat('yyyy-MM-dd').format(_today));
    super.initState();
  }

  @override
  void dispose() {
    _date.dispose();
    _searchLine.dispose();
    super.dispose();
  }

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
                      'Search films',
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
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextField(
                      controller: _searchLine,
                      onTapOutside: (pointer) =>
                          FocusScope.of(context).unfocus(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        label: Text(
                          'Search film',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      readOnly: true,
                      controller: _date,
                      style: Theme.of(context).textTheme.bodyMedium,
                      onTap: () async {
                        var data = await showDatePicker(
                          context: context,
                          initialDate: _today,
                          firstDate: _today,
                          lastDate: DateTime(
                            _today.year + 1,
                            _today.month,
                            _today.day,
                          ),
                        );
                        data != null
                            ? _date.text = DateFormat('yyyy-MM-dd').format(data)
                            : null;
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: context.read<AppAuthBloc>().state.dioClient.getFilms(
                        _date.text,
                        _searchLine.text,
                      ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    FilmInfo(film: snapshot.data![index],
                                    stringDate: _date.text),
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
          ),
        ),
      ),
    );
  }
}
