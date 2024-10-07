import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:picapool/screens/location_fetch_screen.dart';
import 'package:picapool/widgets/Sell_Form_Page0.dart';
import 'package:picapool/widgets/Electronics/ElectronicsPage2.dart';

class ElectronicsPage1 extends StatefulWidget {
  @override
  State<ElectronicsPage1> createState() => _ElectronicsPage1State();
}

class _ElectronicsPage1State extends State<ElectronicsPage1> {
  String currentLocation = "6th st, Connaught place, New Delhi, India";
  List<File> _imageFiles = []; // Store cropped images
  int selectedConditionIndex = -1; // To keep track of selected condition

  void _updateLocation(String location) {
    setState(() {
      currentLocation = location;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        File? croppedImage = await _cropImage(File(image.path));
        if (croppedImage != null) {
          setState(() {
            _imageFiles.add(croppedImage);
          });
        }
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.orange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  icon: Icon(Icons.arrow_back, color: Color(0xffFF8D41),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 8),
                Text(
                  'Include some details',
                  style: TextStyle(
                    fontFamily: "MontserratM",
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: StepIndicator(currentStep: 2),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: _imageFiles.isEmpty
                            ? Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined, size: 60, color: Colors.orange),
                                    Text('Add image', style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  autoPlay: false,
                                ),
                                items: _imageFiles.map((image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.file(
                                              image,
                                              width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: GestureDetector(
                                              onTap: _pickImage,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.orange,
                                                child: Icon(Icons.add, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: buildTextField(
                        label: 'Device Type:', hintText: 'e.g., laptop, smartphone'),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: buildTextField(label: 'Model name', hintText: ''),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: buildTextField(label: 'Brand', hintText: ''),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: buildTextField(
                        label: 'Add description',
                        hintText: 'e.g., description details',
                        maxLength: 200),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: buildTextField(
                        label: 'Accessories Included', hintText: ''),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: buildTextField(label: 'MRP', hintText: ''),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      'Condition',
                      style: TextStyle(
                        fontFamily: "MontserratR",
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     buildConditionContainer(
                        svgPath: 'assets/icons/new.svg',
                        label: 'New',
                        index: 0,
                        isSelected: selectedConditionIndex == 0,
                      ),
                      buildConditionContainer(
                        svgPath: 'assets/icons/used.svg',
                        label: 'Used',
                        index: 1,
                        isSelected: selectedConditionIndex == 1,
                      ),
                      buildConditionContainer(
                        svgPath: 'assets/icons/repaired.svg',
                        label: 'Repaired',
                        index: 2,
                        isSelected: selectedConditionIndex == 2,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ElectronicsPage2()),
                            );
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
                                    fontSize: 16,
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
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConditionContainer({
    required String svgPath,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedConditionIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected ? Colors.orange : Color(0xffA3A3A3)),
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: isSelected ? Colors.black : Color(0xffA3A3A3),
              width: 40,
              height: 40,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                  fontFamily: "MontserratR",
                  fontSize: 12,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      {required String label, required String hintText, int? maxLength}) {
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
            hintStyle: TextStyle(
              color: Colors.grey,
              fontFamily: 'MontserratR',
              fontSize: 12,
            ),
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
          maxLength: maxLength,
          style: TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
        ),
      ],
    );
  }
}
