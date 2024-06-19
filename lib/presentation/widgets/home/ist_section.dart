
// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:svg_flutter/svg_flutter.dart';

class IstSectionHomeView extends StatelessWidget {
  const IstSectionHomeView({
    super.key,
    required this.expandText,
    required this.hideCircleRow,
  });

  final bool expandText;
  final bool hideCircleRow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AnimatedSize(
                duration: 800.ms,
                curve: Curves.linear,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: !expandText ? 10 : context.sizeWidth(0.48),
                  decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.secondary.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        ImagesPaths.mapPoint,
                        color: context.colorScheme.secondary,
                        height: 20,
                      ).animate().fadeInFromLeft(delay: 450.ms, animationDuration: 500.ms),
                      Flexible(
                        child: const AutoSizeText(
                          'Saint Petersburg',
                          maxLines: 1,
                        ).animate().fadeInFromLeft(delay: 600.ms, animationDuration: 800.ms),
                      )
                    ].rowInPadding(5),
                  ),
                ),
              ).animate(delay: 2000.ms),
            ),
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(ImagesPaths.face),
            ).scale(animationDuration: 900.ms),
          ],
        ),

        // hi marina
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hi, Marina',
              style: context.textTheme.bodyLarge,
            ).fadeInFromLeft(delay: 1500.ms),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'let\'s select your',
                  style: context.textTheme.titleLarge,
                  textScaleFactor: 1.2,
                ).fadeInFromBottom(delay: 1800.ms, animationDuration: 450.ms),
                Text(
                  'perfect place',
                  style: context.textTheme.titleLarge,
                  textScaleFactor: 1.2,
                ).fadeInFromBottom(delay: 2100.ms, animationDuration: 500.ms),
              ],
            )
          ],
        ),
      ].columnInPadding(hideCircleRow ? 10 : 20),
    );
  }
}
