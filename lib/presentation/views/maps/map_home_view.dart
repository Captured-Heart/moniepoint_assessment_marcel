import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moniepoint_assessment_marcel/data/map_home_mixins.dart';

import '../../../app.dart';

class MapHomeView extends StatefulWidget {
  const MapHomeView({super.key, required this.darkMapStyle});
  final String? darkMapStyle;

  @override
  State<MapHomeView> createState() => MapSampleState();
}

class MapSampleState extends State<MapHomeView> with MapHomeMixins {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // google map
          GoogleMap(
            mapType: MapType.normal,
            style: widget.darkMapStyle ?? darkMapStyle,
            compassEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
          ),

          // extended fab button in bottomRight
          extendedRightFabBTN(context),

          // left icons in column
          Positioned(
            left: 30,
            bottom: context.sizeHeight(0.11),
            child: OverlayDialog(
              animationController: animationController,
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

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'created by $this');
  }
}
