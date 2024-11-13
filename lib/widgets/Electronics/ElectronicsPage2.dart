import 'package:flutter/material.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/screens/sell/select_category_page.dart';

class ElectronicsPage2 extends StatefulWidget {
  @override
  State<ElectronicsPage2> createState() => _ElectronicsPage2State();
}

class _ElectronicsPage2State extends State<ElectronicsPage2> {
  String currentLocation = "6th st, Connaught place, New Delhi, India";
  bool isLessThanMonth = false; // To track the state of the checkbox
  TextEditingController yearsController = TextEditingController();
  TextEditingController monthsController = TextEditingController();

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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xffFF8D41)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Almost done',
                    style: TextStyle(
                      fontFamily: "MontserratM",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepIndicator(currentStep: 3),
                  SizedBox(height: 20),
                  Text(
                    "Time Held",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'MontserratR',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: buildSmallTextField(
                          controller: yearsController,
                          hintText: '',
                          enabled: !isLessThanMonth,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Years",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'MontserratR',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 80,
                        child: buildSmallTextField(
                          controller: monthsController,
                          hintText: '',
                          enabled: !isLessThanMonth,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Months",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'MontserratR',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CheckboxListTile(
                      title: Text("Less than a month"),
                      value: isLessThanMonth,
                      onChanged: (newValue) {
                        setState(() {
                          isLessThanMonth = newValue ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Color(0xffFF8D41),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  buildUnderlineTextField(
                      label: 'Reason for sell:', hintText: ''),
                  SizedBox(height: 20),
                  buildUnderlineTextField(
                      label: 'Selling price:', hintText: ''),
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
                            'Sell now',
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

  Widget buildSmallTextField({
    required TextEditingController controller,
    required String hintText,
    required bool enabled,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: enabled ? Color(0xFFA3A3A3) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFFF8D41),
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      enabled: enabled,
      style: TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
    );
  }

  Widget buildUnderlineTextField({
    required String label,
    required String hintText,
  }) {
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

  Widget buildTextField({
    required String label,
    required String hintText,
  }) {
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
                color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
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
