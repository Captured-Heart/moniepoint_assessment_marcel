// ignore_for_file: deprecated_member_use
// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:moniepoint_assessment_marcel/data/ripple_effect_mixins.dart';

import 'app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with RippleEffectMixin {
  @override
  void initState() {
    setBegin = 30;
    setEnd = 20;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
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

            // bottom nav bar and screens
            const BottomNavBarWidget(),
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
