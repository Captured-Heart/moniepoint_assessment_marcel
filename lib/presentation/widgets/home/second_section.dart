import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/home/text_number_column.dart';

class SecondSectionHomeView extends StatelessWidget {
  const SecondSectionHomeView(
      {super.key, required this.numValue1, required this.numValue2, required this.hideCircleRow});
  final int numValue1;
  final int numValue2;
  final bool hideCircleRow;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: TextAndNumbersColumn(
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
                child: TextAndNumbersColumn(
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
      ].columnInPadding(15),
    );
  }
}
