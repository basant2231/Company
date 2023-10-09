import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';

class SocialInfo extends StatelessWidget {
  final String label;
  final String content;

  SocialInfo({
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            content,
            style: TextStyle(
              color: MyColors.ddarkindego, // Make sure MyColors is defined or replace it with a color
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
