
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class ListOfMarkersWidget extends StatefulWidget {
  const ListOfMarkersWidget({super.key, required this.isExpanded});

  final bool isExpanded;

  @override
  State<ListOfMarkersWidget> createState() => _ListOfMarkersWidgetState();
}

class _ListOfMarkersWidgetState extends State<ListOfMarkersWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1200.ms);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool overlayExpanded = widget.isExpanded;
    return Stack(
      children: [
        ...List.generate(
          6,
          (index) => Positioned(
            top: context.sizeHeight([0.23, 0.295, 0.5, 0.32, 0.45, 0.55][index]),
            left: context.sizeWidth([0.3, 0.35, 0.2, 0.7, 0.7, 0.6][index]),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Transform.scale(
                    scale: _animation.value,
                    alignment: Alignment.bottomLeft,
                    child: AnimatedContainer(
                      duration: 800.ms,
                      width: !overlayExpanded ? 35 : 75,
                      padding:
                          EdgeInsets.symmetric(horizontal: !overlayExpanded ? 8 : 12, vertical: 12),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )),
                      child: !overlayExpanded
                          ? Icon(
                              Icons.apartment_rounded,
                              color: context.colorScheme.surface,
                              size: 20,
                            )
                          : AutoSizeText(
                              [
                                '10,3 mn ₽',
                                '11 mn ₽',
                                '13,3 mn ₽',
                                '7,8 mn ₽',
                                '8,5 mn ₽',
                                '6,95 mn ₽'
                              ][index],
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 10,
                                color: context.colorScheme.surface,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
