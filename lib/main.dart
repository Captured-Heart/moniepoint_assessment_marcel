// ignore_for_file: deprecated_member_use

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/animations/ink_response.dart';
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
      home: const BottomNavBarWrapper(),
    );
  }
}

class BottomNavBarWrapper extends StatefulWidget {
  const BottomNavBarWrapper({super.key});

  @override
  State<BottomNavBarWrapper> createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper>
    with RippleEffectMixin {
  int pageIndex = 2;
  int numValue1 = 0;
  int numValue2 = 0;
  String? _darkMapStyle;

  @override
  void initState() {
    setBegin = 30;
    setEnd = 20;
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
            //map screen
            MapHomeView(darkMapStyle: _darkMapStyle),
            //chat screen
            PagesPlaceholderWidget(
                navbarIcons: navbarIcons, pageIndex: pageIndex),
            // home screen
            const HomeView(),
            //heart screen
            PagesPlaceholderWidget(
                navbarIcons: navbarIcons, pageIndex: pageIndex),
            // profile screen
            PagesPlaceholderWidget(
                navbarIcons: navbarIcons, pageIndex: pageIndex),
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
                    ...List.generate(
                        5,
                        (index) => inkResponseWidget(
                              index,
                              context,
                              child: SvgPicture.asset(
                                navbarIcons.values.toList()[index],
                                color: context.colorScheme.surface,
                                height: pageIndex == index ? 28 : null,
                              ),
                              onTap: () {
                                onTap();
                                setState(() {
                                  pageIndex = index;
                                });
                              },
                              rippleAnimation: rippleAnimation,
                              width: pageIndex == index ? 55 : 47,
                              height: pageIndex == index ? 55 : 47,
                              showRipple: pageIndex == index,
                              onHideBorder: onHideBorder,
                              decoration: BoxDecoration(
                                color: pageIndex == index && !onHideBorder
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onSurface,
                                shape: BoxShape.circle,
                                border: onHideBorder && pageIndex == index
                                    ? Border.all(
                                        color: context.colorScheme.surface,
                                        width: 1)
                                    : null,
                              ),
                            )

                        // navBarIcons(index, context),
                        ),
                  ],
                ),
              ),
            ).padOnly(bottom: context.sizeHeight(0.015)),
          ).slideInFromBottom(
              delay: 3000.ms, animationDuration: 2500.ms, begin: 0.9),
        ],
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'created by $this');
  }
}
