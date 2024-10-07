import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/screens/Public%20Chat/publicChatScreen.dart';

class AlertsPage extends StatefulWidget {
  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final List<Map<String, String>> alerts = [
    {
      'title': 'LEVI sale',
      'category': 'Clothes and fabric',
      'image': 'assets/icons/alert_image.png',
      'time': '5 mins ago',
      'details': 'Buy 1 Get 1 Free',
      'expires_in': '11:59',
      'distance': '225 metres away',
      'people_in_chat': '2 people in chat',
    },
    {
      'title': 'KFC offer',
      'category': 'Food and beverages',
      'image': 'assets/icons/alert_image.png',
      'time': '5 mins ago',
      'details': 'Buy 6 or more Chicken Nuggets & get 50% Off',
      'expires_in': '11:59',
      'distance': '225 metres away',
      'people_in_chat': '2 people in chat',
    },
    // Add more alerts as needed
  ];

  String selectedCategory = 'All Offers';
  List<bool> expandedStates = [];

  @override
  void initState() {
    super.initState();
    expandedStates = List.filled(alerts.length, false); // Initially, all cards are collapsed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02005D),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Alerts',
            style: TextStyle(
              fontFamily: "MontserratM",
              fontSize: 24,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xff02005D),
      ),
      body: Column(
        children: [
          // Category Buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Color(0xff02005D),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    CategoryButton(
                      image: 'assets/icons/all.png',
                      label: 'All Offers',
                      selected: selectedCategory == 'All Offers',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'All Offers';
                        });
                      },
                    ),
                    CategoryButton(
                      image: 'assets/icons/food.png',
                      label: 'Food',
                      selected: selectedCategory == 'Food',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Food';
                        });
                      },
                    ),
                    CategoryButton(
                      image: 'assets/icons/ball.png',
                      label: 'Sports',
                      selected: selectedCategory == 'Sports',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Sports';
                        });
                      },
                    ),
                    CategoryButton(
                      image: 'assets/icons/ball.png',
                      label: 'Services',
                      selected: selectedCategory == 'Services',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Services';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Alert List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            expandedStates[index] = !expandedStates[index]; // Toggle expansion state
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: expandedStates[index] ? 240 : 120, // Adjust the height to fit content
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: expandedStates[index] ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Collapsed state: Only show title, category, and time
                                        if (!expandedStates[index])
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    alerts[index]['title'] ?? '',
                                                    style: TextStyle(fontSize: 16, fontFamily: "MontserratM"),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    alerts[index]['time'] ?? '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "MontserratM",
                                                      color: Color(0xff7B7B7B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/tshirt.png',
                                                    width: 15,
                                                    height: 15,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    alerts[index]['category'] ?? '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "MontserratM",
                                                      color: Color(0xff7B7B7B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        Spacer(),
                                        // Expanded state: Show additional information
                                        if (expandedStates[index])
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                alerts[index]['details'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "MontserratM",
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              if (alerts[index]['expires_in'] != null)
                                                Row(
                                                  children: [
                                                    Icon(Icons.access_time, size: 18, color: Colors.orange),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "Expires in ${alerts[index]['expires_in']}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "MontserratM",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 5),
                                              if (alerts[index]['distance'] != null)
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on, size: 18, color: Colors.orange),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      alerts[index]['distance'] ?? '',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "MontserratM",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 5),
                                              if (alerts[index]['people_in_chat'] != null)
                                                Row(
                                                  children: [
                                                    Icon(Icons.group, size: 18, color: Colors.orange),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      alerts[index]['people_in_chat'] ?? '',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "MontserratM",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 10),
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PublicChatPage()));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xffFF8D41),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Join Chat',
                                                    style: TextStyle(
                                                      fontFamily: "MontserratM",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (!expandedStates[index])
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/clock.png',
                                                    width: 15,
                                                    height: 15,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    " 59:59",
                                                    style: TextStyle(fontSize: 16, fontFamily: "MontserratM"),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 55.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      expandedStates[index] ? "Hide Details" : "See Details",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "MontserratM"),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Icon(
                                                      expandedStates[index]
                                                          ? Icons.arrow_drop_up
                                                          : Icons.arrow_drop_down,
                                                      size: 15,
                                                      color: Color(0xffFF8D41),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Image.asset(
                                      alerts[index]['image']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool selected;
  final String image;
  final VoidCallback onTap;

  CategoryButton({
    required this.label,
    required this.image,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: selected ? Colors.white : Colors.black,
          backgroundColor: selected ? Color(0xffFF8D41) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: onTap,
        icon: Image.asset(image, width: 20, height: 20),
        label: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
