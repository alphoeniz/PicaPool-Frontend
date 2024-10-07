import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/models/button_model.dart';
import 'package:picapool/screens/cabs/share_cab.dart';
import 'package:picapool/screens/create_cab.dart';
import 'package:picapool/screens/turf/turf_first_page.dart';
import 'package:picapool/screens/vicinity/request_vicinity.dart';
import 'package:picapool/utils/svg_icon.dart';
import 'package:picapool/widgets/home/bottom_modal_sheet.dart';
import 'package:picapool/widgets/home/carousel.dart';
import 'package:picapool/widgets/home/divider.dart';
import 'package:picapool/widgets/home/list_categories.dart';
import 'package:picapool/widgets/product_lists/product_lists.dart';

class DownSheet extends StatefulWidget {
  const DownSheet({Key? key}) : super(key: key);

  @override
  State<DownSheet> createState() => _DownSheetState();
}

class _DownSheetState extends State<DownSheet> {
  List<ButtonModel> data = [
    ButtonModel(
        text: "Food", imagePath: "assets/categories/food.png", onTap: () {}),
    ButtonModel(
        text: "Apparel",
        imagePath: "assets/categories/apparel.png",
        onTap: () {}),
    ButtonModel(
        text: "Entertainment",
        imagePath: "assets/categories/entertainment.png",
        onTap: () {}),
    ButtonModel(
        text: "Electronics",
        imagePath: "assets/categories/electronics.png",
        onTap: () {}),
    ButtonModel(
        text: "Personal\nCare",
        imagePath: "assets/categories/care.png",
        onTap: () {}),
    ButtonModel(
        text: "Subscription",
        imagePath: "assets/categories/subscription.png",
        onTap: () {}),
    ButtonModel(
        text: "Furniture",
        imagePath: "assets/categories/furniture.png",
        onTap: () {}),
    ButtonModel(
        text: "Health & Wellness",
        imagePath: "assets/categories/medicine.png",
        onTap: () {}),
  ];

  final List<Map<String, String>> brands = [
    {'name': 'Food', 'asset': 'assets/homepagebottomassets/image 39.png'},
    {'name': 'Apparel', 'asset': 'assets/homepagebottomassets/image 41.png'},
    {'name': 'Entertain', 'asset': 'assets/homepagebottomassets/image 42.png'},
    {'name': 'Food', 'asset': 'assets/homepagebottomassets/image 39.png'},
    {'name': 'Medicine', 'asset': 'assets/homepagebottomassets/image 43.png'},
    {'name': 'Electronics', 'asset': 'assets/homepagebottomassets/image 44.png'},
    {'name': 'Music', 'asset': 'assets/homepagebottomassets/image 46.png'},
    {'name': 'Medicine', 'asset': 'assets/homepagebottomassets/image 43.png'},
    // Add more brands as needed
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      child: Container(
        // margin: const EdgeInsets.only(bottom: 4),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(24, 2, 24, 0),
        height: size.height - 270,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffF1F1F1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29), topRight: Radius.circular(29)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //TODO: make reponsive for big screens
                  InkWell(
                    onTap: () {
                      Get.to(() => const CabShareScreen());
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/share_cab.png",
                          width: size.width * 0.275,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Share a cab",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListsPage(),
                        ),
                      );
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/buy_sell.png",
                          width: size.width * 0.275,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Buy and sell",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => TurfPage1());
                    },
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/share_turf.png",
                          width: size.width * 0.275,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Share a turf",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),

              //VIEW MORE BUTTON
              InkWell(
                onTap: () {
                  showCustomModalBottomSheet(context);
                },
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFFD8BE),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View more",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: const Color(0xffFF8D41),
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 6),
                        const SvgIcon("assets/icons/down_circular.svg",
                            size: 14)
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),
              const CarouselWidget(),
              const SizedBox(
                height: 14,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: CustomDivider(text: " Pooling Categories "),
              ),
              const SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: brands.map((brand) => _buildBrandItem(brand)).toList(),
                  ),
                ),
              
              const SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: brands.map((brand) => _buildBrandItem(brand)).toList(),
                  ),
                ),
              const SizedBox(
                height: 110,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildBrandItem(Map<String, String> brand) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  brand['asset']!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              brand['name']!,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "MontserratR",
              ),
            ),
          ],
        ),
      ),
    );
  }


