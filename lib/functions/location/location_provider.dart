import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;

final locationProvider =
    StateNotifierProvider<LocationController, LocationState>(
  (ref) => LocationController(),
);

class LocationState {
  final Location? location;
  final bool isLoading;
  final String? locationName;
  final String? errorMessage;

  LocationState({
    this.location,
    this.isLoading = false,
    this.errorMessage,
    this.locationName = "New Delhi",
  });

  LocationState copyWith({
    Location? location,
    bool? isLoading,
    String? errorMessage,
    String? locationName,
  }) {
    return LocationState(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      locationName: locationName ?? this.locationName,
    );
  }
}

// Create a LocationController to manage the location logic
class LocationController extends StateNotifier<LocationState> {
  LocationController() : super(LocationState());

  // Request permission and fetch the current location
  Future<void> getLocation() async {
    state = state.copyWith(isLoading: true);

    bool serviceEnabled;
    geo.LocationPermission permission;
    try {
      serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return;
        }
      }

      if (permission == geo.LocationPermission.deniedForever) {
        return;
      }

      geo.Position position = await geo.Geolocator.getCurrentPosition(
          locationSettings: const geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
        distanceFilter: 10,
      ));

      await getAddressFromLatLng(
        lat: position.latitude,
        lng: position.longitude,
      );

      state = state.copyWith(
        location: Location(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.timestamp(),
        ),
        isLoading: false,
      );
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to get location: ${e.toString()}',
      );
    }
  }

  Future<void> getAddressFromLatLng(
      {required double lat, required double lng}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      lng,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      String address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      state = state.copyWith(locationName: address);
      print("Added location name");
    } else {
      state = state.copyWith(locationName: "Unknown location");
    }
  }

  // Future<void> getLocation() async {
  //   state = state.copyWith(isLoading: true);

  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       serviceEnabled = await Geolocator.requestPermission();
  //       if (!serviceEnabled) {
  //         throw Exception('Location services are disabled.');
  //       }
  //     }

  //     PermissionStatus permissionGranted =
  //         await _locationService.hasPermission();
  //     if (permissionGranted == PermissionStatus.denied) {
  //       permissionGranted = await _locationService.requestPermission();
  //       if (permissionGranted != PermissionStatus.granted) {
  //         throw Exception('Location permission not granted.');
  //       }
  //     }

  //     final locationData = await _locationService.getLocation();

  //     state = state.copyWith(location: locationData, isLoading: false, locationName: locationData.);
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Failed to get location: ${e.toString()}',
  //     );
  //   }
  // }
}
