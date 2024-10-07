import 'package:flutter/material.dart';
import 'package:picapool/screens/Products/selected_product_page.dart';

class ViewProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'MontserratM',
            fontSize: 16,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'), // Replace with your image asset path
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find "playstation" products',
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
            // Products Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 8, // Number of items
                itemBuilder: (context, index) {
                  return _buildProductCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    final List<Map<String, String>> products = [
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'sold_out'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'available'
      },
      {
        'image': 'assets/images/ps 5.png', // Replace with your image asset path
        'title': 'Game console Apple iPad play',
        'price': '₹ 400',
        'status': 'sold_out'
      },
    ];

    final product = products[index];
    final isSoldOut = product['status'] == 'sold_out';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectedProductPage()), // Navigate to SelectedProductPage
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    product['image']!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Game console',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'MontserratR',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        product['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'MontserratM',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        product['price']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'MontserratM',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isSoldOut)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'SOLD OUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'MontserratM',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

