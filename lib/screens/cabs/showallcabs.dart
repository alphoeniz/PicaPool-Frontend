import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picapool/screens/cabs/CreateCab.dart';
import 'package:picapool/screens/create_pool.dart';

class ShowAllCabDetails extends StatelessWidget {
  const ShowAllCabDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Share a cab",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCabPoolScreen()));
        },
        child: Icon(Icons.add, color: Color(0xffffffff),),
        backgroundColor: Color(0xffFF8D41),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildWhiteContainer(),
              SizedBox(height: 16),
              AvailableRidesTitle(),
              SizedBox(height: 16),
              buildCabCard("5:45 pm"),
              SizedBox(height: 12),
              buildCabCard("9:85 pm"),
              SizedBox(height: 12),
              buildCabCard("25:89 pm"),
              SizedBox(height: 12),
              buildCabCard("2:75 pm"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWhiteContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          LocationSelector(),
          SizedBox(height: 30),
          DateSelector(),
        ],
      ),
    );
  }

  Widget buildCabCard(String time) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(fontFamily: "MontserratM", fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: index < 2 ? 2 : 0),
                            child: Icon(Icons.person, size: 16, color: Color(0xffFF8D41)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        "6th street, C...",
                        style: TextStyle(fontFamily: "MontserratM"),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "See Route",
                      style: TextStyle(fontFamily: "MontserratM", color: Color(0xffFF8D41)),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      AssetImage("assets/icons/bus.png"),
                      color: Colors.white,
                      size: 10,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Join Chat",
                      style: TextStyle(
                        fontFamily: "MontserratR",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF8D41),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

class LocationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildLocationRow(Colors.orange[100]!, "6th street, Connaught place, New deli..."),
        SizedBox(height: 25),
        buildLocationRow(Colors.orange, "6th street, Connaught place, New deli..."),
      ],
    );
  }

  Widget buildLocationRow(Color color, String text) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: Colors.orange),
          SizedBox(width: 8),
          Text(
            "24 June , 2024",
            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
        ],
      ),
    );
  }
}

class AvailableRidesTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Available rides",
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }
}
