import 'package:cinema_booking/domain/entities/comment.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBlock extends StatelessWidget {
  const CommentBlock({Key? key, required this.filmId}) : super(key: key);
  final int filmId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
      return FutureBuilder(
        future: state.dioClient.getComments(filmId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text('No reviews yet, let be first!'),
                ),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CommentWidget(comment: snapshot.data![index]);
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    });
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 45,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        comment.author ?? "Anonymously",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Row(
                      children: List<Widget>.generate(
                        comment.rating,
                        (index) => const Icon(
                          Icons.star,
                          color: Color(0xFFffca37),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.content,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Visibility(
                      visible: comment.isMy,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AppAuthBloc>()
                              .state
                              .dioClient
                              .deleteComment(comment.id)
                              .then((value) => context
                                  .read<AppAuthBloc>()
                                  .add(RefreshEvent()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
