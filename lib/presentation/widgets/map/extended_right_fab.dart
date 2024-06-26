import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class ExtendedRightFabBTN extends StatelessWidget {
  const ExtendedRightFabBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.sizeHeight(0.11),
      right: 20,
      child: Card(
        elevation: 0,
        shape: const StadiumBorder(),
        color: context.colorScheme.tertiary.withOpacity(0.6),
        child: Row(
                children: [
          Icon(
            Icons.sort_rounded,
            color: context.colorScheme.surface.withOpacity(0.7),
            size: 18,
          ),
          Text(
            'List of variants',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surface.withOpacity(0.7),
            ),
          ),
        ].rowInPadding(5))
            .padAll(15),
      ).scale(animationDuration: 1400.ms, delay: 200.ms),
    );
  }
}
