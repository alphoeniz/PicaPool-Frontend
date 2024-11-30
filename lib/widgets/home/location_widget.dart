import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/utils/svg_icon.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    super.key,
    this.color = Colors.white,
  });
  final Color? color;

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLocation();
    });
  }

  void _fetchLocation() async {
    if (locationController.state.value.location == null) {
      await locationController.getLocation();
    }
  }

  String _extractMainLocation(String location) {
    // Splitting the address based on commas
    List<String> parts = location.split(',');
    
    // Assuming the last part is the country, the second last is the city
    if (parts.length >= 3) {
      // This will show the second last part as the main location (like the city or major area)
      return parts[parts.length - 3].trim();
    } else if (parts.length >= 2) {
      // If the address is short, show the last part before the country
      return parts[parts.length - 1].trim();
    } else {
      // If the address is too short, just return the entire address
      return location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String mainLocation = locationController.state.value.location != null
          ? _extractMainLocation(
              locationController.state.value.locationName ?? "")
          : "Locating...";

      return Row(
        children: [
          InkWell(
            onTap: () {
              debugPrint("Location tapped");
              Get.to(() => const LocationScreen());
            },
            child: Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Row(
                children: [
                  Icon(Icons.location_on, color: widget.color),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              mainLocation, // Display the main or landmark part of the location
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: widget.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: widget.color,
                            ),
                          ],
                        ),
                        Text(
                          locationController.state.value.errorMessage != null
                              ? locationController.state.value.errorMessage!
                              : mainLocation,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: widget.color,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const SvgIcon(
              "assets/icons/profile.svg",
              size: 34,
            ),
          ),
        ],
      );
    });
  }
}
