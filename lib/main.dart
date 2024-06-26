// ignore_for_file: deprecated_member_use
// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:svg_flutter/svg_flutter.dart';

import 'app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  bool _onHideBorder = false;
  late double _begin, _end;

  // ----- home page values -----
  int _pageIndex = 2;

  @override
  void initState() {
    super.initState();
    _begin = 30;
    _end = 20;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.lightTheme,
      themeMode: ThemeMode.light,
      home: Scaffold(
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

            // ---------- ALL VIEWS ------------------
            [
              //map screen
              const MapHomeView(),
              //chat screen
              const SizedBox(),
              // home screen
              const HomeView(),
              //heart screen
              const SizedBox(),
              // profile screen
              const SizedBox(),
            ][_pageIndex],

            // -------------- NAV BAR WIDGET -------------------
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
                        (index) => InkResponseWidget(
                          index: index,
                          onTap: () {
                            _onTap();
                            setState(() {
                              _pageIndex = index;
                            });
                          },
                          rippleAnimation: _rippleAnimation,
                          width: _pageIndex == index ? 55 : 47,
                          height: _pageIndex == index ? 55 : 47,
                          showRipple: _pageIndex == index,
                          onHideBorder: _onHideBorder,
                          decoration: BoxDecoration(
                            color: _pageIndex == index && !_onHideBorder
                                ? AppColors.primary
                                : _pageIndex == 0
                                    ? Colors.black26
                                    : context.colorScheme.onSurface,
                            shape: BoxShape.circle,
                            border: _onHideBorder && _pageIndex == index
                                ? Border.all(color: context.colorScheme.surface, width: 1)
                                : null,
                          ),
                          child: SvgPicture.asset(
                            navbarIcons.values.toList()[index],
                            color: context.colorScheme.surface,
                            height: _pageIndex == index ? 28 : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).padOnly(bottom: context.sizeHeight(0.015)),
            ).slideInFromBottom(delay: 3000.ms, animationDuration: 2500.ms, begin: 0.9),
          ],
        ),
      ),
    );
  }
}
