import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/shared/constants/extensions.dart';

class SliderButton extends StatefulWidget {
  const SliderButton({
    super.key,
    required this.milliseconds,
    required this.text,
  });

  final String text;
  final int milliseconds;
  @override
  SliderButtonState createState() => SliderButtonState();
}

class SliderButtonState extends State<SliderButton> {
  bool _isTransformed = false;
  bool _hideText = true;
  int _milliseconds = 200;

  @override
  void initState() {
    super.initState();
    _milliseconds = widget.milliseconds;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: _milliseconds), () {
        setState(() {
          _isTransformed = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _isTransformed ? context.sizeWidth(0.8) : 45,
      height: 42,
      onEnd: () {
        setState(() {
          _hideText = false;
        });
      },
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(_isTransformed ? 100 : 10),
      ),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            child: _hideText
                ? const SizedBox.shrink()
                : Text(
                    widget.text,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          Positioned(
            right: 0,

            //there will be
            child: Container(
              width: 45,
              height: 40,
              margin: _isTransformed ? const EdgeInsets.all(2) : null,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
