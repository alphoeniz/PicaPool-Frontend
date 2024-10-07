import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoolOffersScreen extends StatefulWidget {
  @override
  _PoolOffersScreenState createState() => _PoolOffersScreenState();
}

class _PoolOffersScreenState extends State<PoolOffersScreen> {
  static const LatLng _center = LatLng(25.276987, 55.296249);
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Google Map Section
            Positioned.fill(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
              ),
            ),
            // Pools found container
            Positioned(
              bottom: 350,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Pools found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: "MontserratM",
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '56',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontFamily: "MontserratM",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Top Container with Dividers and 'Pools near me' Text
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.orange.withOpacity(0.6),
                        thickness: 1,
                        endIndent: 8,
                      ),
                    ),
                    const Text(
                      'Pools near me',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "MontserratM",
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.orange.withOpacity(0.6),
                        thickness: 1,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Container with Offers List
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 300, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gray container with divider and prefix icon
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.orange, indent: 20,),),
                        SizedBox(width: 10),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                
                                Icon(Icons.local_offer, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  'All Offers',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "MontserratM",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.orange, indent: 10,),),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView(
                        children: [
                          OfferContainer(
                            title: 'LEVI sale',
                            subtitle: 'Clothes and fabric',
                            timeAgo: '5 mins ago',
                            countdown: '59:59',
                            icon: Icons.checkroom,
                          ),
                          OfferContainer(
                            title: 'KFC offer',
                            subtitle: 'Food and beverage',
                            timeAgo: '5 mins ago',
                            countdown: '59:59',
                            icon: Icons.fastfood,
                          ),
                          OfferContainer(
                            title: 'St. Joseph turf',
                            subtitle: 'Sport and fitness',
                            timeAgo: '10 mins ago',
                            countdown: '30:15',
                            icon: Icons.sports_soccer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// OfferContainer widget
class OfferContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final String countdown;
  final IconData icon;

  const OfferContainer({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.countdown,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 92,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "MontserratM",
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      timeAgo,
                      style: TextStyle(color: Colors.grey, fontFamily: "MontserratM",),
                      
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(icon, color: Colors.orange),
                    SizedBox(width: 5),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey, fontFamily: "MontserratM",),
                    ),
                    SizedBox(width: 10), // Added spacing
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.orange),
                        SizedBox(width: 5),
                        Text(
                          countdown,
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "MontserratM",),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.orange,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
