import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/utils/svg_icon.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, this.location});
  final String? location;

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
    String mainLocation = location != null ? _extractMainLocation(location!) : "Locating...";

    return Row(
      children: [
        InkWell(
          onTap: (){},
          child: Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                const SvgIcon(
                  "assets/icons/location_pin.svg",
                  size: 26,
                ),
                const SizedBox(
                  width: 8,
                ),
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
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const SvgIcon(
                            "assets/icons/arrow_down.svg",
                            size: 5,
                          )
                        ],
                      ),
                      Text(
                        location ?? "Choose a location",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
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
        )
      ],
    );
  }
}
