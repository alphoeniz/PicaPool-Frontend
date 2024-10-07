import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:geolocator/geolocator.dart';

class RequestVicinity extends StatefulWidget {
  const RequestVicinity({super.key});

  @override
  State<RequestVicinity> createState() => _RequestVicinityState();
}

class _RequestVicinityState extends State<RequestVicinity> {
  double _radius = 500;
  double _waitTime = 30;
  bool _isCollapsed = false;
  List<XFile>? _imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  bool _is3DView = false;
  GoogleMapController? _controller;
  LatLng? _currentPosition;
  Marker? _pinMarker;
  Circle? _currentLocationCircle;
  bool _isMapInitialized = false; // New flag to check if the map is initialized

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle location service not enabled case
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle permission denied case
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle permission permanently denied case
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _updateMarkersAndCircles();

      if (_controller != null && !_isMapInitialized) {
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _currentPosition!,
              zoom: 14.0,
            ),
          ),
        );
        _isMapInitialized =
            true; // Map is now initialized with the current location
      }
    });
  }

  void _updateMarkersAndCircles() {
    setState(() {
      if (_currentPosition != null) {
        _currentLocationCircle = Circle(
          circleId: const CircleId("currentLocationCircle"),
          center: _currentPosition!,
          radius: 100,
          strokeColor: Colors.blue,
          strokeWidth: 2,
          fillColor: Colors.blue.withOpacity(0.3),
        );

        _pinMarker = Marker(
          markerId: const MarkerId("selectedLocation"),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: "Your Location",
          ),
        );
      }
    });
  }

  void _toggle3DView() {
    if (_controller != null && _currentPosition != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition!,
            zoom: 16.0,
            tilt: _is3DView ? 0.0 : 45.0, // Toggle tilt for 3D view
            bearing: _is3DView ? 0.0 : 45.0, // Toggle bearing for 3D effect
          ),
        ),
      );
      setState(() {
        _is3DView = !_is3DView;
      });
    }
  }

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles.take(3).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: [
            // App bar and top section
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isCollapsed ? 60 : 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                indent: 25,
                                thickness: 1,
                                color: const Color(0xffFF8D41),
                              ),
                            ),
                            const Text(
                              "  Request Vicinity  ",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "MontserratM"),
                            ),
                            Expanded(
                              child: Divider(
                                endIndent: 25,
                                thickness: 1,
                                color: const Color(0xffFF8D41),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!_isCollapsed)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: "Add Title",
                                            labelStyle: const TextStyle(
                                                fontFamily: "MontserratM",
                                                color: Colors.grey),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                color: Color(0xffFF8D41),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: "Add Description",
                                            labelStyle: const TextStyle(
                                                fontFamily: "MontserratM",
                                                color: Colors.grey),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                color: Color(0xffFF8D41),
                                              ),
                                            ),
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: _pickImages,
                                    child: Container(
                                      width: 104,
                                      height: 104,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: _imageFiles == null ||
                                              _imageFiles!.isEmpty
                                          ? const Center(
                                              child: Icon(
                                                Icons.add_photo_alternate,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : PageView.builder(
                                              itemCount: _imageFiles!.length,
                                              itemBuilder: (context, index) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    File(_imageFiles![index]
                                                        .path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isCollapsed = !_isCollapsed;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFEEE2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffFF8D41),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isCollapsed
                              ? Icons.arrow_drop_down_outlined
                              : Icons.arrow_drop_up_outlined,
                          color: const Color(0xffFF8D41),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Map section
            Expanded(
              child: Stack(
                children: [
                  _currentPosition == null
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _currentPosition!,
                            zoom: 14.0,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller = controller;
                            _controller!.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: _currentPosition!,
                                  zoom: 14.0,
                                ),
                              ),
                            );
                          },
                          markers: _pinMarker != null ? {_pinMarker!} : {},
                          circles: _currentLocationCircle != null
                              ? {_currentLocationCircle!}
                              : {},
                        ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _toggle3DView,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xffFF8D41),
                          ),
                          child: Text(
                            _is3DView
                                ? "2D View"
                                : "3D View", // Change text based on the current view
                            style: const TextStyle(
                              fontFamily: "MontserratM",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            children: const [
                              Text(
                                "Pooling with ",
                                style: TextStyle(
                                    fontFamily: "MontserratM", fontSize: 10),
                              ),
                              Text(
                                "56",
                                style: TextStyle(
                                    fontFamily: "MontserratSB",
                                    fontSize: 16,
                                    color: Color(0xffFF8D41)),
                              ),
                              Text(
                                "users",
                                style: TextStyle(
                                    fontFamily: "MontserratM", fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // New Radius and Wait Time Pickers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 25,
                          thickness: 1,
                          color: const Color(0xffFF8D41),
                        ),
                      ),
                      const Text(
                        "  Radius and wait time  ",
                        style: TextStyle(
                          fontFamily: "MontserratM",
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          endIndent: 25,
                          thickness: 1,
                          color: const Color(0xffFF8D41),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text("Radius (m)",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "MontserratM")),
                          const SizedBox(width: 8),
                          NumberPicker(
                            minValue: 200,
                            maxValue: 3000,
                            value: _radius.toInt(),
                            step: 100,
                            onChanged: (value) {
                              setState(() {
                                _radius = value.toDouble();
                              });
                            },
                            itemWidth: 50, // Smaller width
                            textStyle: const TextStyle(
                                fontFamily: "MontserratM",
                                fontSize: 12,
                                color: Colors.grey),
                            selectedTextStyle: const TextStyle(
                                fontFamily: "MontserratM",
                                fontSize: 16,
                                color: Colors.black),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Wait Time (min)",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "MontserratM")),
                          const SizedBox(width: 8),
                          NumberPicker(
                            minValue: 10,
                            maxValue: 60,
                            value: _waitTime.toInt(),
                            step: 5,
                            onChanged: (value) {
                              setState(() {
                                _waitTime = value.toDouble();
                              });
                            },
                            itemWidth: 50, // Smaller width
                            textStyle: const TextStyle(
                                fontFamily: "MontserratM",
                                fontSize: 12,
                                color: Colors.grey),
                            selectedTextStyle: const TextStyle(
                                fontFamily: "MontserratM",
                                fontSize: 16,
                                color: Colors.black),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Start Pooling button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle Start Pooling
                },
                child: const Text(
                  "Start Pooling",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "MontserratSB",
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xffFF8D41),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
