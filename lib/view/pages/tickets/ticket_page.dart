import 'package:cinema_booking/domain/entities/ticket.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/pages/tickets/ticket_archive.dart';
import 'package:cinema_booking/view/themes/ui_components/tikckets/ticket_dialog_window.dart';
import 'package:cinema_booking/view/themes/ui_components/tikckets/ticket_tale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(
              'Your`s tickets',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    context.read<AppAuthBloc>().state.dioClient.getTickets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _ifHaveActualTickets(snapshot.data!)
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return Visibility(
                                visible: snapshot.data![index].date >
                                    (DateTime.now().millisecondsSinceEpoch /
                                            1000)
                                        .floor(),
                                child: InkWell(
                                  onTap: () => showTicket(
                                      snapshot.data![index], context),
                                  child: TicketTale(
                                    ticket: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data?.length,
                          )
                        : const Center(
                            child: Text(
                              "You don`t have active ticket\nYou can see old tickets in archive",
                              textAlign: TextAlign.center,
                            ),
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TicketsArchive(),
              ),
            ),
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.archive,
                  size: 50,
                )),
          ),
        )
      ],
    );
  }

  bool _ifHaveActualTickets(List<Ticket> tickets) {
    bool ifHave = false;
    for (var element in tickets) {
      element.date > (DateTime.now().millisecondsSinceEpoch / 1000).floor()
          ? ifHave = true
          : null;
    }
    return ifHave;
  }
}
