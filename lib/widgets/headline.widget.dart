import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  final String title;
  const HeadlineWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
