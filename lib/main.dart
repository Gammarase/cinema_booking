import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/pages/main_nav.dart';
import 'package:cinema_booking/view/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => AppAuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.lightTheme ? Themes.light : Themes.dark,
        home: const MyHomePage(),
      );
    });
  }
}
