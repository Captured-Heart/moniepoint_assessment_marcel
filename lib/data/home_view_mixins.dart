import 'package:flutter/material.dart';

mixin HomeViewMixins<T extends StatefulWidget> on State<T> {
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

  int get numValue1 => _numValue1;
  int get numValue2 => _numValue2;
  bool get expandText => _expandText;
  bool get hideCircleRow => _hideCircleRow;
}
