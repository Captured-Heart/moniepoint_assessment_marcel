import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class SecondSectionHomeView extends StatelessWidget {
  const SecondSectionHomeView(
      {super.key, required this.numValue1, required this.numValue2, required this.hideCircleRow});
  final int numValue1;
  final int numValue2;
  final bool hideCircleRow;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: textAndNumbersColumn(
                  context,
                  title: 'BUY',
                  isCircle: true,
                  numValue: numValue1,
                ),
              ).scale(delay: 1800.ms, animationDuration: 1000.ms),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: textAndNumbersColumn(
                  context,
                  title: 'RENT',
                  numValue: numValue2,
                ),
              ).scale(delay: 1800.ms, animationDuration: 1000.ms),
            )
          ],
        ),

        //
        Offstage(
          offstage: !hideCircleRow,
          child: const BottomSheetImageWidget().slideInFromBottom(
            delay: 2700.ms,
            animationDuration: 1200.ms,
            begin: 1,
          ),
        ),
      ],
    );
  }

  Column textAndNumbersColumn(
    BuildContext context, {
    required String title,
    bool isCircle = false,
    int numValue = 0,
  }) {
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