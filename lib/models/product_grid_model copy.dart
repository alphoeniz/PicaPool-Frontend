import 'package:flutter/material.dart';
import 'package:picapool/screens/product_buy_page.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Canon Camera',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'OnePlus Phone',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
    {
      'image': 'assets/images/harrypotter.jpg',
      'title': 'Harry Potter Book',
      'price': '₹400',
      'originalPrice': '₹1098',
      'time': '2w ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(
          image: products[index]['image'],
          title: products[index]['title'],
          price: products[index]['price'],
          originalPrice: products[index]['originalPrice'],
          time: products[index]['time'],
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String originalPrice;
  final String time;

  ProductItem({
    required this.image,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  ProductDetailsPage()),
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
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
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
                      originalPrice,
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
                  time,
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