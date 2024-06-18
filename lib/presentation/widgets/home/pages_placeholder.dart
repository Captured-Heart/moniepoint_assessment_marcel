import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class PagesPlaceholderWidget extends StatelessWidget {
  const PagesPlaceholderWidget({
    super.key,
    required this.navbarIcons,
    required this.pageIndex,
  });

  final Map<String, String> navbarIcons;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          navbarIcons.keys.toList()[pageIndex],
          style: context.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
