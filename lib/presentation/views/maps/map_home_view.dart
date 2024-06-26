import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app.dart';

class MapHomeView extends StatefulWidget {
  const MapHomeView({super.key, this.darkMapStyle});
  final String? darkMapStyle;

  @override
  State<MapHomeView> createState() => MapSampleState();
}

class MapSampleState extends State<MapHomeView> with SingleTickerProviderStateMixin {
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
        _setExpandedFalse();
      } else {
        _setExpandedTrue();
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

  void _setExpandedFalse() {
    setState(() {
      _isExpanded = false;
    });
  }

  void _setExpandedTrue() {
    setState(() {
      _isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // google map
          GoogleMap(
            mapType: MapType.normal,
            style: widget.darkMapStyle ?? _darkMapStyle,
            compassEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          // extended fab button in bottomRight
          const ExtendedRightFabBTN(),

          // left icons in column
          Positioned(
            left: 30,
            bottom: context.sizeHeight(0.11),
            child: OverlayDialog(
              animationController: _animationController,
            ),
          ),

          // search bar
          const SearchBarWidget(),

          //markers
          ListOfMarkersWidget(
            isExpanded: _isExpanded,
          )
        ],
      ),
    );
  }
}
