// ignore_for_file: deprecated_member_use

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/app.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int numValue1 = 0;
  int numValue2 = 0;
  bool expandText = false;
  bool hideCircleRow = false;
  @override
  void initState() {
    numbersFunction();
    animateWidth();
    hideCircleWidget();
    super.initState();
  }

  void numbersFunction() {
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        numValue1 = 1034;
        numValue2 = 2212;
      });
    });
  }

  void animateWidth() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        expandText = true;
      });
    });
  }

  void hideCircleWidget() {
    Future.delayed(const Duration(milliseconds: 2600), () {
      setState(() {
        hideCircleRow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // saint petersburg row
            Column(
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
                                )
                                    .animate()
                                    .fadeInFromLeft(delay: 600.ms, animationDuration: 800.ms),
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

                // BUY AND RENT ROW WIDGETS
                Stack(
                  children: [
                    SizedBox(
                      height: context.sizeHeight(0.18),
                      child: Row(
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
                ),
              ].columnInPadding(hideCircleRow ? 10 : 20),
            ).padSymmetric(horizontal: 15, vertical: 10),
          ],
        ),
      ),
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
