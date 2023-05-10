import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/pages/account/account_page.dart';
import 'package:cinema_booking/view/pages/films/film_page.dart';
import 'package:cinema_booking/view/pages/tickets/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var pages = const [FilmsPage(), TicketsPage(), AccountPage()]
      .map<Widget>(
        (e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: e,
        ),
      )
      .toList();

  var navElements = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.movie),
      label: 'Films',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sticky_note_2),
      label: 'Tickets',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Account',
    ),
  ];

  int pageNum = 0;

  late TabController _tabPageController;

  @override
  void initState() {
    context.read<AppAuthBloc>().add(Authorization());
    _tabPageController = TabController(
      length: pages.length,
      vsync: this,
    );
    _tabPageController.addListener(() {
      setState(() {
        pageNum = _tabPageController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
      if (state is AuthorisedState) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              if (index != pageNum) {
                setState(() {
                  pageNum = index;
                });
                _tabPageController.animateTo(pageNum,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              }
            },
            currentIndex: pageNum,
            items: navElements,
          ),
          body: SafeArea(
              child: TabBarView(
            controller: _tabPageController,
            children: pages,
          )),
        );
      } else if (state is AuthorisationFailedState) {
        return const Scaffold(
          body: Center(
            child: Text('Authorisation failed'),
          ),
        );
      } else {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
