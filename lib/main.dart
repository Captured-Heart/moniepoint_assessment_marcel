import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/ripple_btn_animation.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/ripple_trial.dart';
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
      home: BottomNavBarWrapper(),
    );
  }
}

class BottomNavBarWrapper extends StatefulWidget {
  const BottomNavBarWrapper({super.key});

  @override
  State<BottomNavBarWrapper> createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper> with RippleEffectMixin {
  int pageIndex = 2;
  int numValue1 = 0;
  int numValue2 = 0;
  String? _darkMapStyle;

  @override
  void initState() {
    _loadMapStyles();

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        numValue1 = 1034;
        numValue2 = 2212;
      });
    });
    super.initState();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(ImagesPaths.darkModeMap);
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
          // the background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.bgGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          [
            MapHomeView(
              darkMapStyle: _darkMapStyle,
            ),
            Placeholder(),
            HomeView(),
            Placeholder(),
            Placeholder()
          ][pageIndex],
          // MapHomeView(),
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
                    ...List.generate(5, (index) => rippleAnimationWidget(index, context)),
                  ],
                ),
              ),
            ).padOnly(bottom: context.sizeHeight(0.015)),
          ).slideInFromBottom(delay: 3600.ms, animationDuration: 3000.ms, begin: 0.9),
        ],
      ),
    );
  }

  InkResponse rippleAnimationWidget(int index, BuildContext context) {
    return InkResponse(
      onTap: () {
        onTap();
        setState(() {
          pageIndex = index;
        });
      },
      containedInkWell: true,
      highlightShape: BoxShape.circle,
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: 500.ms,
        padding: const EdgeInsets.all(12),
        curve: Curves.easeInOut,
        width: pageIndex == index ? 55 : 47,
        height: pageIndex == index ? 55 : 47,
        decoration: BoxDecoration(
          color: pageIndex == index && !onHideBorder
              ? context.colorScheme.primary
              : context.colorScheme.onSurface,
          shape: BoxShape.circle,
          border: onHideBorder && pageIndex == index
              ? Border.all(color: context.colorScheme.surface, width: 1)
              : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            pageIndex == index
                ? AnimatedBuilder(
                    animation: rippleAnimation,
                    builder: (context, child) {
                      return !onHideBorder
                          ? const SizedBox.shrink()
                          : Center(
                              child: CustomPaint(
                                painter: RipplePainter(rippleAnimation.value),
                              ),
                            );
                    },
                  )
                : const SizedBox.shrink(),
            SvgPicture.asset(
              navbarIcons.values.toList()[index],
              color: context.colorScheme.surface,
              height: pageIndex == index ? 28 : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'created by $this');
  }
}


  // CircleAvatar(
                        //   radius: pageIndex == index ? 27 : 24,
                        //   backgroundColor: pageIndex == index
                        //       ? context.colorScheme.primary
                        //       :
                        //       //  Colors.black.withOpacity(0.2), // for map_view
                        //       context.colorScheme.onSurface,
                        //   child: SvgPicture.asset(
                        //     navbarIcons.values.toList()[index],
                        //     color: context.colorScheme.surface,
                        //     height: pageIndex == index ? 28 : null,
                        //   ),
                        // ).onTapWidget(
                        //     tooltip: navbarIcons.keys.toList()[index],
                        //     onTap: () {
                        //       setState(() {
                        //         pageIndex = index;
                        //       });
                        //     }),