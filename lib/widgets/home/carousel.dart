import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:picapool/widgets/home/divider.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<String> images = [
    'assets/carousel/image1.png',
    'assets/carousel/image2.png',
    'assets/carousel/image3.png',
  ];

//TODO: fix responsiveness of this widget (just fix for big screens)
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: CustomDivider(text: " Amazing offers near you "),
        ),
        // const SizedBox(
        //   height: 6,
        // ),
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(images[itemIndex]),
          ),
          options: CarouselOptions(
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.25,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
