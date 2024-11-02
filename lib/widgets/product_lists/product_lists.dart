import 'package:flutter/material.dart';
import 'package:picapool/models/product_grid_model.dart';
import 'package:picapool/utils/svg_icon.dart';
import 'package:picapool/widgets/Sell_Form_Page0.dart';
import 'package:picapool/widgets/home/location_widget.dart';

class ProductListsPage extends StatefulWidget {
  const ProductListsPage({super.key});

  @override
  State<ProductListsPage> createState() => ProductListsPageState();
}

class ProductListsPageState extends State<ProductListsPage> {
  // List of categories and corresponding icons from assets
  final List<Map<String, String>> categories = [
    {"name": "Electronics", "icon": "assets/icons/electronics.svg"},
    {"name": "Clothes", "icon": "assets/icons/clothes.svg"},
    {"name": "Furniture", "icon": "assets/icons/furniture.svg"},
    {"name": "Electronics", "icon": "assets/icons/electronics.svg"},
    {"name": "Clothes", "icon": "assets/icons/clothes.svg"},
    {"name": "Furniture", "icon": "assets/icons/furniture.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // bottomNavigationBar: NewBottomBarProduct(),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xffFF8D41),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategorySelectionPage(),
              ),
            );
          }),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: LocationWidget(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      children: [
                        SvgIcon(
                          'assets/icons/search_icon.svg',
                          size: 24,
                        ),
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
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        value: '100m',
                        items: <String>['100m', '200m', '500m', '1km']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "MontserratR",
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xffDFDFDF)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            category['icon']!,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            ' ${category['name']}',
                            style: const TextStyle(
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
    );
  }
}
