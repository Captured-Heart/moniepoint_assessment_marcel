import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moniepoint_assessment_marcel/presentation/widgets/overlay_dialog.dart';

import '../../../app.dart';

class MapHomeView extends StatefulWidget {
  const MapHomeView({super.key, required this.darkMapStyle});
  final String? darkMapStyle;

  @override
  State<MapHomeView> createState() => MapSampleState();
}

class MapSampleState extends State<MapHomeView> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late AnimationController _animationController;
  bool isExpanded = true;

  String? _darkMapStyle;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13,
  );

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: 700.ms, reverseDuration: 500.ms);
    _animationController.addStatusListener((listener) {
      log('this is the listener: $listener');
      if (listener == AnimationStatus.dismissed) {
        isExpanded = false;
        setState(() {});
      } else {
        isExpanded = true;
        setState(() {});
      }
    });
    _loadMapStyles();

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
          extendedRightFabBTN(context),

          // left icons in column
          Positioned(
            left: 30,
            bottom: context.sizeHeight(0.11),
            child: OverlayDialog(
              animationController: _animationController,
            ),
          ),

          // search bar
          searchBarWidget(context),

          //markers
          ListOfMarkersWidget(
            isExpanded: isExpanded,
          )
        ],
      ),
    );
  }

// ---------------- EXTENDED RIGHT FAB BUTTON ---------------------
  Positioned extendedRightFabBTN(BuildContext context) {
    return Positioned(
      bottom: context.sizeHeight(0.11),
      right: 20,
      child: Card(
        elevation: 0,
        shape: const StadiumBorder(),
        color: context.colorScheme.tertiary.withOpacity(0.6),
        child: Row(
                children: [
          Icon(
            Icons.sort_rounded,
            color: context.colorScheme.surface.withOpacity(0.7),
            size: 18,
          ),
          Text(
            'List of variants',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surface.withOpacity(0.7),
            ),
          ),
        ].rowInPadding(5))
            .padAll(15),
      ).scale(animationDuration: 1400.ms, delay: 200.ms),
    );
  }
}
