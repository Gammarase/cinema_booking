import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_films_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Account',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Expanded(
          child: BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
            return FutureBuilder(
              future: state.dioClient.getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            child: Icon(
                              Icons.person,
                              size: 100,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                snapshot.data!.name ?? 'Nickname',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text('Additional info:',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          'Account created: ${snapshot.data!.stringCreateDate}'),
                      Text(
                          'Account updated: ${snapshot.data!.stringUpdateDate}'),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('Options:',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => showChangeNameDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('Change name'),
                              Icon(Icons.arrow_forward_ios_outlined)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.black.withOpacity(0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Turn on light in cinema'),
                            BlocBuilder<AppAuthBloc, AppState>(
                                builder: (context, state) {
                              return Switch(
                                  value: state.lightTheme,
                                  onChanged: (isTurned) {
                                    context
                                        .read<AppAuthBloc>()
                                        .add(ChangeThemeEvent());
                                  });
                            })
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteFilms(),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('Favorite movies'),
                              Icon(Icons.arrow_forward_ios_outlined)
                            ],
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Tap to see your tickets',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
        )
      ],
    );
  }
}

showChangeNameDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: Text(
            'Change your name',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your new name:'),
              TextField(
                controller: nameController,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  var tempBloc = context
                      .read<AppAuthBloc>();
                  if (nameController.text.isNotEmpty) {
                    tempBloc.state
                        .dioClient
                        .updateUser(nameController.text)
                        .then((value) =>
                            tempBloc.add(RefreshEvent()));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Confirm')),
          ],
        );
      });
    },
  );
}
