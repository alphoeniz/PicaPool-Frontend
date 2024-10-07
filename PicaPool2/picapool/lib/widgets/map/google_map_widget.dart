import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({super.key, required this.center, required this.circleRadius, required this.markers, required this.mapController});
  final LatLng center;
  final double circleRadius;
  final Set<Marker> markers;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
      },
      initialCameraPosition: CameraPosition(target: center, zoom: 17.25),
      // circles: circles,
      markers: markers,
    );
  }
}
