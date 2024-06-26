// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OverlayDialog extends StatefulWidget {
  const OverlayDialog({super.key, required this.animationController});
  final AnimationController animationController;

  @override
  State<OverlayDialog> createState() => _OverlayDialogState();
}

class _OverlayDialogState extends State<OverlayDialog> with TickerProviderStateMixin {
  final OverlayPortalController _overlayPortalController = OverlayPortalController();
  final OverlayPortalController _overlayPortalController2 = OverlayPortalController();
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  int iconIndex = 0;
  late Animation<double> _animation;
  late double _begin, _end;
  bool _onHideBorder = false;

  @override
  void initState() {
    _begin = 20;
    _end = 15;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(parent: widget.animationController, curve: Curves.linear);

    _rippleAnimation = Tween<double>(
      begin: _begin,
      end: _end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hideBorder();
        _controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _hideBorder() {
    setState(() {
      _onHideBorder = false;
    });
  }

  void _onDisplayBorder() {
    setState(() {
      _onHideBorder = true;
    });
  }

  void _onTap() {
    _onDisplayBorder();
    _controller.forward();
    setState(() {
      widget.animationController.forward() ;

      _overlayPortalController.show();
    });
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
                                    color: index == 1
                                        ? context.colorScheme.primary
                                        : context.colorScheme.secondary,
                                  ),
                                  Text(
                                    dialogOptions[index],
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: index == 1
                                          ? context.colorScheme.primary
                                          : context.colorScheme.secondary,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ].rowInPadding(10),
                              ).onTapWidget(
                                tooltip: dialogOptions[index],
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
                },
                child: InkResponseWidget(
                  index: index,
                  showRipple: iconIndex == index,
                  onHideBorder: _onHideBorder,
                  strokeWidth: 3,
                  onTap: () {
                    _onTap();
                    setState(() {
                      iconIndex = index;
                    });
                  },
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(14),
                  rippleAnimation: _rippleAnimation,
                  decoration: BoxDecoration(
                    color: context.colorScheme.tertiary.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: !_onHideBorder
                        ? null
                        : Border.all(
                            color: context.colorScheme.surface.withOpacity(0.8),
                            width: 1,
                          ),
                  ),
                  child: Transform.rotate(
                    angle: index == 0 ? 0 : 1.0,
                    child: SvgPicture.asset(
                      index == 0 ? ImagesPaths.layers : ImagesPaths.mapArrow,
                      color: context.colorScheme.surface.withOpacity(0.8),
                      height: 17,
                      width: 20,
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
}
