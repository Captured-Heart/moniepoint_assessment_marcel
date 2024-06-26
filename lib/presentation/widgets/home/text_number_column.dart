import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/shared/constants/extensions.dart';

class TextAndNumbersColumn extends StatelessWidget {
  const TextAndNumbersColumn(
      {super.key, required this.title, this.isCircle = false, required this.numValue});

  final String title;
  final bool isCircle;
  final int numValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: isCircle == true ? context.colorScheme.surface : null,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 1.25,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 1500),
                value: numValue,
                wholeDigits: 4,
                hideLeadingZeroes: true,
                thousandSeparator: ' ',
                textStyle: context.textTheme.labelLarge?.copyWith(
                  color: isCircle == true ? context.colorScheme.surface : null,
                ),
              ),
              Text(
                'offers',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isCircle == true ? context.colorScheme.surface : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
