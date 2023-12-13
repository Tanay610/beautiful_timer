import 'package:flutter/material.dart';

class DotPresenter extends StatelessWidget {
  const DotPresenter({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      height: 7,

      /// isActive ? 7 : 26
      width: 20.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(255, 212, 72, 140)
            : const Color(0xFFA74A45).withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }
}
