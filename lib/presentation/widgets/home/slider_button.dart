import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app.dart';

class ImgWidget extends StatefulWidget {
  const ImgWidget({
    super.key,
    this.milliseconds = 3000,
    required this.text,
    this.imgHeight,
    this.imgPath,
    this.sliderWidth,
  });

  final String text;
  final int milliseconds;
  final String? imgPath;
  final double? imgHeight;
  final double? sliderWidth;

  @override
  ImgWidgetState createState() => ImgWidgetState();
}

class ImgWidgetState extends State<ImgWidget> {
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
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            widget.imgPath ?? ImagesPaths.furniture2,
            height: widget.imgHeight ?? context.sizeHeight(0.2),
            width: context.sizeWidth(1),
            cacheHeight: context.sizeHeight(0.2).floor(),
            cacheWidth: context.sizeWidth(1).floor(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: context.sizeWidth(0.05),
          child: AnimatedContainer(
            width: _isTransformed
                ? context.sizeWidth(widget.sliderWidth ?? 0.8)
                : 45,
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
            duration: const Duration(milliseconds: 1200),
            curve: Curves.linear,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  child: _hideText
                      ? const SizedBox.shrink()
                      : AutoSizeText(
                          widget.text,
                          style: context.textTheme.titleLarge?.copyWith(
                            // fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          maxFontSize: 14,
                          minFontSize: 10,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ).fadeInFromLeft(
                          delay: 100.ms, animationDuration: 100.ms),
                ),
                Positioned(
                  right: 0,

                  //there will be
                  child: Container(
                    width: 40,
                    height: 38,
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
          ),
        ),
      ],
    );
  }
}
