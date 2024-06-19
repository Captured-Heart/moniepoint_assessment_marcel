// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moniepoint_assessment_marcel/data/ripple_effect_mixins.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../app.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> with RippleEffectMixin {
  @override
  void initState() {
    setBegin = 30;
    setEnd = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ---------- ALL VIEWS ------------------
        [
          //map screen
          MapHomeView(darkMapStyle: darkMapStyle),
          //chat screen
          PagesPlaceholderWidget(title: navbarIcons.keys.toList()[pageIndex]),
          // home screen
          const HomeView(),
          //heart screen
          PagesPlaceholderWidget(title: navbarIcons.keys.toList()[pageIndex]),
          // profile screen
          PagesPlaceholderWidget(title: navbarIcons.keys.toList()[pageIndex]),
        ][pageIndex],

        // -------------- NAV BAR WIDGET -------------------
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: kBottomNavigationBarHeight * 1.4,
            width: context.sizeWidth(0.82),
            child: navbarWidget(context),
          ).padOnly(bottom: context.sizeHeight(0.015)),
        ).slideInFromBottom(delay: 3000.ms, animationDuration: 2500.ms, begin: 0.9),
      ],
    );
  }

  Card navbarWidget(BuildContext context) {
    return Card(
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
                  setPageIndex = index;
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
                    : pageIndex == 0
                        ? Colors.black26
                        : context.colorScheme.onSurface,
                shape: BoxShape.circle,
                border: onHideBorder && pageIndex == index
                    ? Border.all(color: context.colorScheme.surface, width: 1)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'created by $this');
  }
}
