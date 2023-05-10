import 'package:flutter/material.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton(
      {Key? key, required this.child, this.isAvailable = true, required this.action})
      : super(key: key);
  final Widget child;
  final bool isAvailable;
  final GestureTapCallback action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: isAvailable ? action : null,
        child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height/15,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isAvailable
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            child: Center(child: child)),
      ),
    );
  }
}
