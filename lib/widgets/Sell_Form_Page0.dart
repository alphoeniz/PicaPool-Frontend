import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:picapool/widgets/Electronics/ElectronicsPage1.dart';
import 'package:picapool/widgets/books/BooksPage1.dart';
import 'package:picapool/widgets/clothes/ClothesPage1.dart';
import 'package:picapool/widgets/furniture/Furniturepage1.dart';
import 'package:picapool/widgets/home/location_widget.dart';
import 'package:picapool/widgets/others/OtherPage1.dart';
import 'package:picapool/widgets/sports/SportsPage1.dart';
import 'package:picapool/widgets/vehicle/VehiclePage1.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: LocationWidget(
                color: Colors.black,
              )),
          const Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: StepIndicator(currentStep: 1),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What are you selling?',
                      style: TextStyle(fontSize: 14, fontFamily: "MontserratM"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/electronics-1.svg',
                          label: 'Electronics',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ElectronicsPage1(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/clothes-1.svg',
                          label: 'Clothes',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClothesPage1()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/books-1.svg',
                          label: 'Books',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BooksPage1()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/sports-1.svg',
                          label: 'Sports',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SportsPage1(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/furniture-1.svg',
                          label: 'Furniture',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FurniturePage1()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: 160,
                        child: CategoryCard(
                          svgPath: 'assets/icons/vehicle-1.svg',
                          label: 'Vehicle',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehiclePage1()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtherPage1()),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Other ",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "MontserratR",
                          ),
                        ),
                        Icon(Icons.add_circle, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onTap;

  const CategoryCard(
      {super.key,
      required this.svgPath,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffD4D4D4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgPath,
                width: 70,
                height: 70,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 14, fontFamily: "MontserratR")),
          ],
        ),
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => Container(
                width: 90,
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: currentStep > index ? Colors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              )),
    );
  }
}
