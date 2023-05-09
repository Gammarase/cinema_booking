import 'package:cinema_booking/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class TicketTale extends StatelessWidget {
  final Ticket ticket;

  const TicketTale({Key? key, required this.ticket}) : super(key: key);

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
                  ticket.smallImage,
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
                      ticket.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(ticket.stringDate,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RotatedBox(
                quarterTurns: -1,
                child: Text(
                  'Tap to see info',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
