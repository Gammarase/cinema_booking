import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/themes/ui_components/tikckets/ticket_dialog_window.dart';
import 'package:cinema_booking/view/themes/ui_components/tikckets/ticket_tale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsArchive extends StatelessWidget {
  const TicketsArchive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        "Ticket archive",
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
                          child: const Icon(Icons.arrow_back)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future:
                      context.read<AppAuthBloc>().state.dioClient.getTickets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () =>
                                      showTicket(snapshot.data![index], context),
                                  child: TicketTale(
                                    ticket: snapshot.data![index],
                                  ),
                                );
                              },
                              itemCount: snapshot.data?.length,
                            )
                          : const Center(
                              child: Text(
                                "You don`t have tickets yet",
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
        ),
      ),
    );
  }
}
