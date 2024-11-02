import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:http/http.dart' as http;

class RequestVicinity extends ConsumerStatefulWidget {
  const RequestVicinity({super.key});

  @override
  ConsumerState<RequestVicinity> createState() => _RequestVicinityState();
}

class _RequestVicinityState extends ConsumerState<RequestVicinity> {
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool isLoading = false;
  int poolingUsers = 0;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNearestUsers(authController.state.value.user!.id, 500);
    });
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
          radius: _radius,
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
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _imageFiles = pickedFiles.take(3).toList();
      });
    }
  }

  void createVicinity() async {
    // Call the createVicinity function from the vicinityApiProvider
    setState(() {
      isLoading = true;
    });

    if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      debugPrint("Please fill all the fields");
      setState(() {
        isLoading = false;
      });
      return;
    }

    // final vicinityApi = ;

    final offer = {
      "name": _titleController.text,
      "images": _imageFiles!.map((file) => file.path).toList(),
      "desc": _descController.text,
      "expiry": DateTime.now()
          .add(Duration(minutes: _waitTime.toInt()))
          .toIso8601String(),
      "isOnline": false,
    };

    final userId =
        authController.state.value.user?.id; // Replace with actual user ID
    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      debugPrint("User ID is null");
      return;
    }
    // await vicinityApi.createVicinity(
    //   offer: offer,
    //   destination: _radius.toInt(),
    //   userId: userId,
    // );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      resizeToAvoidBottomInset: true,
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                indent: 25,
                                thickness: 1,
                                color: Color(0xffFF8D41),
                              ),
                            ),
                            Text(
                              "  Request Vicinity  ",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "MontserratM"),
                            ),
                            Expanded(
                              child: Divider(
                                endIndent: 25,
                                thickness: 1,
                                color: Color(0xffFF8D41),
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
                                          controller: _titleController,
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
                                          controller: _descController,
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
                            children: [
                              const Text(
                                "Pooling with ",
                                style: TextStyle(
                                    fontFamily: "MontserratM", fontSize: 10),
                              ),
                              Text(
                                "$poolingUsers",
                                style: const TextStyle(
                                    fontFamily: "MontserratSB",
                                    fontSize: 16,
                                    color: Color(0xffFF8D41)),
                              ),
                              Text(
                                (poolingUsers > 1) ? "users" : "user",
                                style: const TextStyle(
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
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 25,
                          thickness: 1,
                          color: Color(0xffFF8D41),
                        ),
                      ),
                      Text(
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
                          color: Color(0xffFF8D41),
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
                                _currentLocationCircle = Circle(
                                  circleId:
                                      const CircleId("currentLocationCircle"),
                                  center: _currentPosition!,
                                  radius: _radius,
                                  strokeColor: Colors.blue,
                                  strokeWidth: 2,
                                  fillColor: Colors.blue.withOpacity(0.3),
                                );
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
                  createVicinity();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xffFF8D41),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: (isLoading)
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Start Pooling",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "MontserratSB",
                            color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> getNearestUsers(int id, double radius) async {
    String endpoint = "https://api.picapool.com/v2/user/nearest";
    String? at = authController.state.value.auth?.accessToken;
    if (at == null) {
      return [];
    }
    try {
      final response = await http.post(Uri.parse(endpoint),
          body: jsonEncode({'id': id, 'dist': radius}),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $at'
          });

      print(response.statusCode);

      if (response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);
        List<String> usersList = [];

        for (var user in jsonResponse) {
          usersList.add(
            '${user['latitude']} ${user['longitude']}',
          );
        }
        setState(() {
          poolingUsers = usersList.length;
        });
        return usersList;
      } else if (response.statusCode == 401) {
        debugPrint('Failed to load getNearestUsers - status code 401');
        await authController.updateAccessToken();
        return getNearestUsers(id, radius);
      } else {
        debugPrint('Failed to load getNearestUsers - status code not 200');
        return [];
      }
    } catch (err) {
      debugPrint('Failed to fetch getNearestUsers - api error');
      return [];
    }
  }
}
