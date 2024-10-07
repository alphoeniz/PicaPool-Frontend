import 'package:flutter/material.dart';
import 'package:picapool/models/product_grid_model.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/utils/svg_icon.dart';
import 'package:picapool/widgets/Sell_Form_Page0.dart';
import 'package:picapool/widgets/bottom_navbar/bottom_nav_bar_products.dart';
import 'package:picapool/widgets/bottom_navbar/common_bottom_navbar.dart';

class ProductListsPage extends StatefulWidget {
  const ProductListsPage({super.key});

  @override
  State<ProductListsPage> createState() => ProductListsPageState();
}

class ProductListsPageState extends State<ProductListsPage> {
  String currentLocation = "6th st, Connaught place, New Delhi, India";

  // List of categories and corresponding icons from assets
  final List<Map<String, String>> categories = [
    {"name": "Electronics", "icon": "assets/icons/electronics.svg"},
    {"name": "Clothes", "icon": "assets/icons/clothes.svg"},
    {"name": "Furniture", "icon": "assets/icons/furniture.svg"},
    {"name": "Electronics", "icon": "assets/icons/electronics.svg"},
    {"name": "Clothes", "icon": "assets/icons/clothes.svg"},
    {"name": "Furniture", "icon": "assets/icons/furniture.svg"},
  ];

  void _updateLocation(String location) {
    setState(() {
      currentLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: NewBottomBarProduct(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Color(0xffFF8D41),
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategorySelectionPage()));
      }),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LocationScreen(),
                              ),
                            );
                            if (result != null) {
                              _updateLocation(result);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 35,
                                color: Colors.black,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    currentLocation.length > 30
                                        ? '${currentLocation.substring(0, 30)}...'
                                        : currentLocation,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 270,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            SvgIcon('assets/icons/search_icon.svg', size: 24, ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Find Offers and Brands',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MontserratR",
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 105,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              value: '100m',
                              items: <String>[
                                '100m',
                                '200m',
                                '500m',
                                '1km'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "MontserratR",
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {},
                              underline: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Container(
                        width: 150,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xffDFDFDF)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(category['icon']!,
                                size: 24,),
                            SizedBox(width: 10),
                            Text(
                              ' ${category['name']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "MontserratR",
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    indent: 50,
                    color: Color(0xffFF8D41),
                  )),
                  Text(
                    "  Products near you  ",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "MontserratM",
                        fontSize: 14),
                  ),
                  Expanded(
                      child: Divider(
                    endIndent: 50,
                    color: Color(0xffFF8D41),
                  )),
                ]),
                const SizedBox(height: 20),
                Expanded(child: ProductGrid())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
