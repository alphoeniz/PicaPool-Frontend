import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:picapool/widgets/map/google_map_widget.dart';
import 'package:picapool/widgets/pool/add_offer_pic.dart';

class CreatePoolScreen extends StatefulWidget {
  const CreatePoolScreen({super.key});

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> changeCameraPosition(double radius) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        const CameraPosition(
            target: LatLng(17.5957802, 78.1173821), zoom: 15.25)));
  }

  @override
  void initState() {
    super.initState();
    changeCameraPosition(200);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff2D0090),
      body: Stack(
        children: [
          GoogleMapWidget(
              center: const LatLng(17.5957802, 78.1173821),
              circleRadius: 200,
              markers: const {},
              mapController: _controller),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BottomSheet(
                  enableDrag: false,
                  onClosing: () {},
                  builder: (context) {
                    // return  const OfferDetailsForm();
                    return const AddOfferImage();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
