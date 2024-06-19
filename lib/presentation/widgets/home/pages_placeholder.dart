import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class PagesPlaceholderWidget extends StatelessWidget {
  const PagesPlaceholderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          title,
          style: context.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
