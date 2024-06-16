import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/slider_button.dart';
import 'package:svg_flutter/svg.dart';

import 'app.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppThemeData.lightTheme,
      home: MapHomeView(),

      // BottomNavBarWrapper(),
    );
  }
}

class BottomNavBarWrapper extends StatefulWidget {
  const BottomNavBarWrapper({super.key});

  @override
  State<BottomNavBarWrapper> createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper> {
  int pageIndex = 2;
  int numValue1 = 0;
  int numValue2 = 0;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        numValue1 = 1034;
        numValue2 = 2212;
      });
    });
    super.initState();
  }

  Map<String, String> navbarIcons = {
    'Search': ImagesPaths.search,
    'Chat': ImagesPaths.chat,
    'Home': ImagesPaths.home,
    'Heart': ImagesPaths.heart,
    'Profile': ImagesPaths.profile,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.bgGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
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
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    ImagesPaths.mapPoint,
                                    color: context.colorScheme.secondary,
                                    height: 20,
                                  ),
                                  const Text('Saint Petersburg')
                                ].rowInPadding(5),
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(ImagesPaths.face),
                          ),
                        ],
                      ),

                      // hi marina
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Hi, Marina',
                            style: context.textTheme.bodyLarge,
                          ),
                          Text(
                            'let\'s select your\nperfect place',
                            style: context.textTheme.titleLarge,
                            textScaleFactor: 1.2,
                          )
                        ],
                      ),

                      // BUY AND RENT ROW WIDGETS
                      SizedBox(
                        height: context.sizeHeight(0.185),
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
                              ),
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ].columnInPadding(20),
                  ).padSymmetric(horizontal: 15, vertical: 10),
                  BottomSheetImageWidget(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: kBottomNavigationBarHeight * 1.4,
              width: context.sizeWidth(0.82),
              child: Card(
                color: context.colorScheme.onSurface.withOpacity(0.95),
                shape: const StadiumBorder(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      5,
                      (index) => CircleAvatar(
                        radius: pageIndex == index ? 27 : 24,
                        backgroundColor: pageIndex == index
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface,
                        child: SvgPicture.asset(
                          navbarIcons.values.toList()[index],
                          color: context.colorScheme.surface,
                          height: pageIndex == index ? 28 : null,
                        ),
                      ).onTapWidget(
                          tooltip: navbarIcons.keys.toList()[index],
                          onTap: () {
                            setState(() {
                              pageIndex = index;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ).padOnly(bottom: context.sizeHeight(0.015)),
          ),
        ],
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
          heightFactor: 1.35,
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

class BottomSheetImageWidget extends StatelessWidget {
  const BottomSheetImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeWidth(1),
      padding: const EdgeInsets.all(6),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          imgWidget(context),
          SizedBox(
            height: context.sizeHeight(0.45),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: imgWidget(
                      context,
                      imgPath: ImagesPaths.furniture4,
                      imgHeight: context.sizeHeight(0.5),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => Expanded(
                          child: imgWidget(
                            context,
                            imgPath: index.isEven ? ImagesPaths.furniture1 : ImagesPaths.furniture2,
                            imgHeight: context.sizeHeight(0.4),
                          ),
                        ),
                      ).columnInPadding(5),
                    ),
                  )
                ].rowInPadding(5)),
          ).padSymmetric(vertical: 5),
        ],
      ),
    );
  }

  Widget imgWidget(
    BuildContext context, {
    double? imgHeight,
    String? imgPath,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imgPath ?? ImagesPaths.furniture2,
            height: imgHeight ?? context.sizeHeight(0.2),
            width: context.sizeWidth(1),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: context.sizeWidth(0.05),
          right: context.sizeWidth(0.05),
          child: SliderButton(
            milliseconds: 2000,
            text: 'Slide to view',
          ),
        )
      ],
    );
  }
}
