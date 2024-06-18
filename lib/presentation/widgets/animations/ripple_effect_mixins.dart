import 'package:flutter/material.dart';

////////////////////////////

mixin RippleEffectMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;
  bool _onHideBorder = false;
  late double _begin, _end;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _rippleAnimation = Tween<double>(
      begin: _begin,
      end: _end,
      // 20.0,
      // end: 15.0,
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

  Animation<double> get rippleAnimation => _rippleAnimation;
  bool get onHideBorder => _onHideBorder;
  set setBegin(double value) => _begin = value;
  set setEnd(double value) => _end = value;

  void onTap() => _onTap();
}
