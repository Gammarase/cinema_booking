import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({Key? key, required this.filmId}) : super(key: key);
  final int filmId;

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  late List<DropdownMenuItem> ratingOptions;
  late TextEditingController _commentController;
  var currentSelected = 5;

  @override
  void initState() {
    ratingOptions = List.generate(
      5,
      (index) => DropdownMenuItem(
        value: index + 1,
        child: Text((index + 1).toString()),
      ),
    );
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Add new comment'),
              const Expanded(child: SizedBox()),
              DropdownButton(
                  items: ratingOptions,
                  value: currentSelected,
                  onChanged: _dropdownCallback,
                  style: Theme.of(context).textTheme.bodySmall,
                  borderRadius: BorderRadius.circular(10),
                  focusColor: Theme.of(context).colorScheme.background),
              const Icon(
                Icons.star,
                color: Color(0xFFffca37),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onTapOutside: (pointer) => FocusScope.of(context).unfocus(),
                  style: Theme.of(context).textTheme.bodySmall,
                  controller: _commentController,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (_commentController.text.isNotEmpty) {
                    context
                        .read<AppAuthBloc>()
                        .state
                        .dioClient
                        .addComment(_commentController.text, currentSelected,
                            widget.filmId)
                        .then((value) =>
                            context.read<AppAuthBloc>().add(RefreshEvent()));
                    setState(() {
                      _commentController.text = '';
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.send,
                    size: 35,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _dropdownCallback(value) {
    setState(() {
      currentSelected = value;
    });
  }
}
