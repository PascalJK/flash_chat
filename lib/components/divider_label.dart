import 'package:flutter/material.dart';

class Dividerlabel extends StatelessWidget {
  const Dividerlabel({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: .5,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            labelText,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: .5,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
