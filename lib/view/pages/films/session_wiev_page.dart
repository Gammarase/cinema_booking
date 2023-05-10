import 'package:cinema_booking/domain/entities/films_session.dart';
import 'package:cinema_booking/domain/entities/seats_structure.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/pages/films/payment_page.dart';
import 'package:cinema_booking/view/themes/ui_components/app/alert_dialog.dart';
import 'package:cinema_booking/view/themes/ui_components/app/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionView extends StatelessWidget {
  const SessionView({Key? key, required this.session, required this.filmName})
      : super(key: key);
  final FilmSession session;
  final String filmName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        filmName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
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
                            child: const Icon(Icons.arrow_back))),
                  ),
                ],
              ),
            ),
            Text('in ${session.type} at ${session.stringDate}'),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome to ${session.room.name}",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                  Theme.of(context).colorScheme.background == Colors.white
                      ? 'assets/img/screenline.png'
                      : 'assets/img/screenline_dark.png'),
            ),
            SeatsScheme(
                rows: session.room.rows,
                maxWidthRow: _maxLength(session.room.rows)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SeatLabel(color: Colors.lightBlue, text: ' - normal'),
                SeatLabel(
                    color: Theme.of(context).colorScheme.primary,
                    text: ' - better'),
                const SeatLabel(color: Color(0xFFffca37), text: ' - VIP'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<AppAuthBloc, AppState>(
              builder: (context, state) {
                return Text(
                    "Summary price: \$${state.reservedSeats.fold(0, (int previousValue, element) => previousValue += element.price).toString()}");
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<AppAuthBloc, AppState>(
                    builder: (context, state) {
                  return CustomAppButton(
                    isAvailable: state.reservedSeats.isNotEmpty,
                    action: () {
                      var localState = context.read<AppAuthBloc>().state;
                      localState.dioClient
                          .bookSeats(
                              localState.reservedSeats
                                  .map<int>((e) => e.id)
                                  .toList(),
                              session.id)
                          .then(
                            (value) => value
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PaymentPage(
                                          session: session,
                                          filmName: filmName,
                                        );
                                      },
                                    ),
                                  )
                                : showMessage(
                                    'Error while booking seats',
                                    [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      )
                                    ],
                                    context),
                          );
                    },
                    child: Text(
                      'Book & Pay',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.apply(color: Colors.white),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  int _maxLength(List<SeatRow> rows) {
    var result = 0;
    for (var row in rows) {
      if (result < row.seats.length) {
        result = row.seats.length;
      }
    }
    return result;
  }
}

class SeatLabel extends StatelessWidget {
  const SeatLabel({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.width / 10,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
        ),
        Text(text),
      ],
    );
  }
}

class SeatsScheme extends StatelessWidget {
  const SeatsScheme({Key? key, required this.rows, required this.maxWidthRow})
      : super(key: key);
  final List<SeatRow> rows;
  final int maxWidthRow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows
            .map<Widget>(
              (singleRow) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: singleRow.seats
                    .map<Widget>(
                      (seat) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: InkWell(
                          onTap: () {
                            if (seat.isAvailable) {
                              context.read<AppAuthBloc>().add(
                                  state.reservedSeats.contains(seat)
                                      ? RemoveSeatEvent(seat: seat)
                                      : AddSeatEvent(seat: seat));
                            }
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width /
                                    maxWidthRow) -
                                8,
                            height: (MediaQuery.of(context).size.width /
                                    maxWidthRow) -
                                8,
                            decoration: BoxDecoration(
                              color: _colorSelector(seat, context),
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width /
                                    (maxWidthRow * 4),
                              ),
                            ),
                            child: Center(
                                child: state.reservedSeats.contains(seat)
                                    ? Icon(
                                        Icons.check,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                    (maxWidthRow) -
                                                8,
                                      )
                                    : Text(seat.index.toString())),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      );
    });
  }

  _colorSelector(Seat seat, BuildContext context) {
    late Color color;

    if (seat.type == SeatType.normal) {
      color = Colors.lightBlue;
    } else if (seat.type == SeatType.better) {
      color = Theme.of(context).colorScheme.primary;
    } else if (seat.type == SeatType.vip) {
      color = const Color(0xFFffca37);
    }
    return seat.isAvailable ? color : color.withOpacity(0.3);
  }
}
