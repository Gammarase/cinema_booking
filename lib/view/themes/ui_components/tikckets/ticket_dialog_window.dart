import 'package:cinema_booking/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

showTicket(Ticket ticket, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(ticket.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: GridTile(
                header: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                footer: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.background
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
                child: Image.network(
                  ticket.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(ticket.stringDate,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: QrImage(
                data: ticket.id.toString(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          )
        ],
      );
    },
  );
}
