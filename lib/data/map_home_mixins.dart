import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app.dart';

mixin MapHomeMixins<T extends StatefulWidget> on State<T> implements TickerProvider {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late AnimationController _animationController;
  bool _isExpanded = true;
  String? _darkMapStyle;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13,
  );
  @override
  void initState() {
    _loadMapStyles();
    _animationController =
        AnimationController(vsync: this, duration: 700.ms, reverseDuration: 500.ms);
    _animationController.addStatusListener((listener) {
      if (listener == AnimationStatus.dismissed) {
        // _isExpanded = false;
        // setState(() {});
        _setExpanded();
      } else {
        // _isExpanded = true;
        // setState(() {});
        _setExpanded();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(ImagesPaths.darkModeMap);
  }

  void _setExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String get darkMapStyle => _darkMapStyle ?? '';
  CameraPosition get kGooglePlex => _kGooglePlex;
  bool get isExpanded => _isExpanded;
  Completer<GoogleMapController> get googleMapController => _controller;
  AnimationController get animationController => _animationController;
}
