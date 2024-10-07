import 'package:flutter/material.dart';

class OnePlusCommunityOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'One plus Community offer',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'MontserratM',
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offer Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/oneplus.png', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // View Details Text
            Text(
              'View Details',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'MontserratM',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            // Product 1 Details
            _buildProductDetail(
              imagePath: 'assets/images/image 80.png', 
              title: 'OnePlus 11 Pro :',
              display: '6.7" Fluid AMOLED, 120Hz',
              processor: 'Snapdragon 8 Gen 2',
              ram: '12GB/16GB',
              storage: '256GB/512GB',
              camera: '50MP+48MP+8MP rear, 32MP front',
              price: '₹ 40,000',
              originalPrice: '₹ 70,000',
            ),
            SizedBox(height: 20),
            // Product 2 Details
            _buildProductDetail(
              imagePath: 'assets/images/image 82.png', 
              title: 'OnePlus 10 Pro :',
              display: '6.7" Fluid AMOLED, 120Hz',
              processor: 'Snapdragon 8 Gen 1',
              ram: '12GB/16GB',
              storage: '256GB/512GB',
              camera: '50MP+48MP+8MP rear, 32MP front',
              price: '₹ 46,000',
              originalPrice: '₹ 79,000',
            ),
            SizedBox(height: 20),
            // Start Pooling Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle pooling action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF8D41),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: Text(
                  'Start Pooling',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'MontserratM',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetail({
    required String imagePath,
    required String title,
    required String display,
    required String processor,
    required String ram,
    required String storage,
    required String camera,
    required String price,
    required String originalPrice,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'MontserratM',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '• Display: $display\n'
                '• Processor: $processor\n'
                '• RAM: $ram\n'
                '• Storage: $storage\n'
                '• Camera: $camera',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'MontserratR',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  text: price,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'MontserratM',
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' M.R.P. ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'MontserratR',
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: originalPrice,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'MontserratR',
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
