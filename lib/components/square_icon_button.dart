import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({super.key, required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200),
      child: Icon(iconData),
    );
  }
}
