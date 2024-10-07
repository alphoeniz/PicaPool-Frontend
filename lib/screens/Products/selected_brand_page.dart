import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picapool/screens/Products/view_products_page.dart';

class PlayStationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/Vector (1).png', // Replace with your PlayStation logo asset
              width: 30,
              height: 30,
            ),
            SizedBox(width: 8),
            Text(
              'Playstation',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'MontserratM',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                  onPressed: () {
                    // Define what happens when the button is tapped
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF8D41),
                    // side: BorderSide(color: Color(0xffFF6600)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // To minimize the button width
                      children: [
                        Text(
                          'Go to store',
                          style: TextStyle(
                              fontFamily: "MontserratR",
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff)),
                        ),
                        SizedBox(width: 5), // Space between text and icon
                        Icon(Icons.arrow_circle_right_outlined,
                            size: 20,
                            color: Color(
                              0xffFFFFFF,
                            )), // Icon with size
                      ],
                    ),
                  ),
                ),
                ),
                SizedBox(width: 8), // Space between buttons
                Expanded(
                  child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => ViewProductsPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFE9DA),
                    side: BorderSide(color: Color(0xffFF6600)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // To minimize the button width
                      children: [
                        Text(
                          'View products',
                          style: TextStyle(
                              fontFamily: "MontserratR",
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF8D41)),
                        ),
                         // Space between text and icon
                        // Icon with size
                      ],
                    ),
                  ),
                ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between buttons and search bar
            // Search Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find Offers and Brands',
                  hintStyle: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: "MontserratR",
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Offer Banner
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/Group 401.png', // Replace with your offer image asset
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'See Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'MontserratM',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Limited Offers
            Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 40,
                        thickness: 1,
                        color: const Color(0xffFF8D41),
                      ),
                    ),
                    const Text(
                      "  Limited Offers  ",
                      style: TextStyle(fontSize: 16, fontFamily: "MontserratM"),
                    ),
                    Expanded(
                      child: Divider(
                        endIndent: 40,
                        thickness: 1,
                        color: const Color(0xffFF8D41),
                      ),
                    ),
                  ],
                ),
            SizedBox(height: 10),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/image 79.png', // Replace with your offer image asset
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'See Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'MontserratM',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.orange,
      //   unselectedItemColor: Colors.grey,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   currentIndex: 0, // Change this to the appropriate index based on selection
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: 'Chats',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Alerts',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   onTap: (index) {
      //     // Handle bottom navigation tap
      //   },
      // ),
    );
  }
}
