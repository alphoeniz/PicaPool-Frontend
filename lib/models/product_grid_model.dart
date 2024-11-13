import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picapool/controllers/product_controller.dart';
import 'package:picapool/screens/product_buy_page.dart';
import 'package:picapool/utils/date_time_helper.dart';

class ProductGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        builder: (ProductController productInstance) {
      return productInstance.productsState == ProductsState.productsLoaded
          ? GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              // itemCount: products.length,
              itemCount: productInstance.productsList.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  image: productInstance.productsList[index].pic?.first ?? "",
                  title: productInstance.productsList[index].name ?? "No Name",
                  price: productInstance.productsList[index].price.toString() ,
                  offerPrice: productInstance.productsList[index].offerPriceMin.toString() ,
                  time: productInstance.productsList[index].updatedAt?.toIso8601String() ?? " " ,
                );
              },
            )
          : const Center(
              child: LinearProgressIndicator(),
            );
    });
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String offerPrice;
  final String time;

  ProductItem({
    required this.image,
    required this.title,
    required this.price,
    required this.offerPrice,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  base64Decode(
                  image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontFamily: "MontserratR",
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: "MontserratM",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      offerPrice,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "MontserratM",
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                Text(
                  DateTimeHelper.timeAgoSince(time),
                  style: TextStyle(
                    fontFamily: "MontserratM",
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
