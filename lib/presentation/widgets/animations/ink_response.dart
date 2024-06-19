import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app.dart';

Widget inkResponseWidget(
  int index,
  BuildContext context, {
  double? width,
  double? height,
  EdgeInsets? padding,
  Decoration? decoration,
  bool showRipple = false,
  required Widget child,
  required VoidCallback onTap,
  bool onHideBorder = false,
  required Animation<double> rippleAnimation,
  double? strokeWidth,
}) {
  return Tooltip(
    message: navbarIcons.entries.toList()[index].key,
    child: InkResponse(
      onTap: onTap,
      containedInkWell: true,
      highlightShape: BoxShape.circle,
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: 300.ms,
        padding: padding ?? const EdgeInsets.all(12),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: decoration,
        child: Stack(
          fit: StackFit.expand,
          children: [
            showRipple
                ? AnimatedBuilder(
                    animation: rippleAnimation,
                    builder: (context, child) {
                      return !onHideBorder
                          ? const SizedBox.shrink()
                          : Center(
                              child: CustomPaint(
                                painter:
                                    RipplePainter(rippleAnimation.value, strokeWidth: strokeWidth),
                              ),
                            );
                    },
                  )
                : const SizedBox.shrink(),
            child,
          ],
        ),
      ),
    ),
  );
}
