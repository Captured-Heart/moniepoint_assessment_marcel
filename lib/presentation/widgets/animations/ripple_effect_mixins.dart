import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app.dart';

////////////////////////////

mixin RippleEffectMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  // -------- map page values ---------
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  bool _onHideBorder = false;
  late double _begin, _end;

  // ----- home page values -----
  int _pageIndex = 2;
  int _numValue1 = 0;
  int _numValue2 = 0;
  String? _darkMapStyle;

  @override
  void initState() {
    super.initState();
    _setAnimatedTextValues();
    _loadMapStyles();
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
      pageIndex;
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

  void _setAnimatedTextValues() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _numValue1 = 1034;
        _numValue2 = 2212;
      });
    });
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(ImagesPaths.darkModeMap);
  }

  Animation<double> get rippleAnimation => _rippleAnimation;
  bool get onHideBorder => _onHideBorder;
  set setBegin(double value) => _begin = value;
  set setEnd(double value) => _end = value;

  // ---- home getters && setters ----
  set setPageIndex(int value) => _pageIndex = value;
  int get pageIndex => _pageIndex;
  int get numValue1 => _numValue1;
  int get numValue2 => _numValue2;
  String? get darkMapStyle => _darkMapStyle;

  void onTap() => _onTap();
}
