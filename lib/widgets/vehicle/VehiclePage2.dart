import 'package:flutter/material.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/screens/sell/select_category_page.dart';

class VehiclePage2 extends StatefulWidget {
  @override
  State<VehiclePage2> createState() => _VehiclePage2State();
}

class _VehiclePage2State extends State<VehiclePage2> {
  String currentLocation = "6th st, Connaught place, New Delhi, India";
   void _updateLocation(String location) {
    setState(() {
      currentLocation = location;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LocationScreen(),
                              ),
                            );
                            if (result != null) {
                              _updateLocation(result);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 35,
                                color: Colors.black,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    currentLocation.length > 30
                                        ? '${currentLocation.substring(0, 30)}...'
                                        : currentLocation,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(currentStep: 3),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: buildTextField(label: 'Time held (Years):', hintText: '')),
                      SizedBox(width: 10),
                  Expanded(child: buildTextField(label: 'Months:', hintText: '')),
                    ],
                  ),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CheckboxListTile(
                      title: Text("Less than a month"),
                      value: false,
                      onChanged: (newValue) {},
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  buildUnderlineTextField(label: 'Reason for sell:', hintText: ''),
                  SizedBox(height: 20),
                  buildUnderlineTextField(label: 'Selling price:', hintText: ''),
                  SizedBox(height: 20),
                  buildTextField(label: 'Phone number:', hintText: ''),
                  SizedBox(height: 20),
                  buildTextField(label: 'Email ID:', hintText: ''),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle final sell action
                      },
                       style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF8D41),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
                      child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "MontserratSB"),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUnderlineTextField({required String label, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: 'MontserratR',
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: 'MontserratR',
              fontSize: 14,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 5),
          ),
          style: TextStyle(fontSize: 16, fontFamily: 'MontserratR'),
        ),
      ],
    );
  }

  Widget buildTextField({required String label, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'MontserratR',
            ),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFA3A3A3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFFF8D41), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          style: TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
        ),
      ],
    );
  }
}
