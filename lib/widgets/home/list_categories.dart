import 'package:flutter/material.dart';
import 'package:picapool/models/button_model.dart';
import 'package:picapool/widgets/home/category_card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.data});
  final List<ButtonModel> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95*2 + 4, // Adjust this height to fit two lines of items
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: generateListOfWidget().sublist(0, (data.length + 1) ~/ 2),
              ),
              const SizedBox(height: 22.0), // Spacing between the rows
              Row(
                mainAxisSize: MainAxisSize.min,
                children: generateListOfWidget().sublist((data.length + 1) ~/ 2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> generateListOfWidget() {
    return List.generate(
      data.length,
      (index) => Padding(
        padding: const EdgeInsets.only(right: 7.0), // Adjust spacing as needed
        child: CategoriesCard(data: data.elementAt(index)),
      ),
    );
  }
}
