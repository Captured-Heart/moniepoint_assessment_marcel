// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/animations/ink_response.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OverlayDialog extends StatefulWidget {
  const OverlayDialog({super.key, required this.animationController});
  final AnimationController animationController;

  @override
  State<OverlayDialog> createState() => _OverlayDialogState();
}

class _OverlayDialogState extends State<OverlayDialog> with RippleEffectMixin {
  final OverlayPortalController _overlayPortalController = OverlayPortalController();
  final OverlayPortalController _overlayPortalController2 = OverlayPortalController();
  int iconIndex = 0;
  late Animation<double> _animation;

  @override
  void initState() {
    setBegin = 20;
    setEnd = 15;
    _animation = CurvedAnimation(
      parent: widget.animationController,
      curve: Curves.linear,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            ...List.generate(
              2,
              (index) => OverlayPortal(
                controller: [_overlayPortalController, _overlayPortalController2][index],
                overlayChildBuilder: (context) {
                  // overlay dialog
                  return overlayWidget(context);
                },
                child: inkResponseWidget(
                  index,
                  context,
                  showRipple: iconIndex == index,
                  onHideBorder: onHideBorder,
                  strokeWidth: 3,
                  onTap: () {
                    onTap();
                    setState(() {
                      iconIndex = index;
                      widget.animationController.forward();
                      _overlayPortalController.show();
                    });
                  },
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(14),
                  child: Transform.rotate(
                    angle: index == 0 ? 0 : 1.0,
                    child: SvgPicture.asset(
                      index == 0 ? ImagesPaths.layers : ImagesPaths.mapArrow,
                      color: context.colorScheme.surface.withOpacity(0.8),
                      height: 17,
                      width: 20,
                    ),
                  ),
                  rippleAnimation: rippleAnimation,
                  decoration: BoxDecoration(
                    color: context.colorScheme.tertiary.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: !onHideBorder
                        ? null
                        : Border.all(
                            color: context.colorScheme.surface.withOpacity(0.8),
                            width: 1,
                          ),
                  ),
                ).scale(animationDuration: 1500.ms, delay: 200.ms),
              ),
            ).columnInPadding(5)
          ],
        );
      },
    );
  }

// Overlay widget
  Positioned overlayWidget(BuildContext context) {
    return Positioned(
      bottom: context.sizeHeight(0.175),
      left: 30,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Transform.scale(
          scale: _animation.value,
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 14, top: 14, right: 10),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                4,
                (index) => Row(
                  children: [
                    SvgPicture.asset(
                      [
                        ImagesPaths.shield,
                        ImagesPaths.wallet,
                        ImagesPaths.trash,
                        ImagesPaths.layers
                      ][index],
                      height: 20,
                      color:
                          index == 1 ? context.colorScheme.primary : context.colorScheme.secondary,
                    ),
                    Text(
                      ['Cosy areas', 'Price', 'Infrastructure', 'Without any layer'][index],
                      style: context.textTheme.bodySmall?.copyWith(
                        color: index == 1
                            ? context.colorScheme.primary
                            : context.colorScheme.secondary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ].rowInPadding(10),
                ).onTapWidget(
                  tooltip: '',
                  onTap: () {
                    setState(() {
                      widget.animationController.reverse();
                    });
                  },
                ),
              ).columnInPadding(15),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
