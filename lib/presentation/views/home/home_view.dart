// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:moniepoint_assessment_marcel/app.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _numValue1 = 0;
  int _numValue2 = 0;
  bool _expandText = false;
  bool _hideCircleRow = false;
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
        _numValue1 = 1034;
        _numValue2 = 2212;
      });
    });
  }

  void animateWidth() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _expandText = true;
      });
    });
  }

  void hideCircleWidget() {
    Future.delayed(const Duration(milliseconds: 2600), () {
      setState(() {
        _hideCircleRow = true;
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
            IstSectionHomeView(expandText: _expandText, hideCircleRow: _hideCircleRow)
                .padSymmetric(horizontal: 15, vertical: 10),
            // BUY AND RENT ROW WIDGETS
            SecondSectionHomeView(
              numValue1: _numValue1,
              numValue2: _numValue2,
              hideCircleRow: _hideCircleRow,
            ),
          ],
        ),
      ),
    );
  }
}
