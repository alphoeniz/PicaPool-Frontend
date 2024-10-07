import 'package:flutter/material.dart';
import 'package:picapool/models/button_model.dart';
import 'package:picapool/utils/center_custom_text.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key, required this.data});
  final ButtonModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: SizedBox(
                  height: 68,
                  child: Center(
                    child: Image.asset(
                      data.imagePath!,
                      width: 64,
                    ),
                  ),
                )),
            CenterAlignText(
                text: data.text,
                size: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000)),
          ],
        ),
      ),
    );
  }
}
