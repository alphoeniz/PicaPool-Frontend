// widgets/category_form_widget.dart

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picapool/controllers/sell_form_controller.dart';
// import 'package:picapool/screens/sell/config/category_config.dart';
// import 'package:picapool/widgets/sell/dimensions_fields.dart';
// import 'package:picapool/widgets/location_bar.dart';
// import 'package:picapool/widgets/sell/build_field.dart';
import 'package:picapool/utils/routes.dart';
import 'package:picapool/widgets/location_app_bar.dart';
import 'package:picapool/widgets/primary_button.dart';
import 'package:picapool/widgets/sell/build_field.dart';
import 'package:picapool/widgets/sell/condition_chips.dart';
import 'package:picapool/widgets/sell/image_picker_widget.dart';
import 'package:picapool/widgets/forms/electronics_form.dart';
import 'package:picapool/widgets/forms/books_form.dart';
import 'package:picapool/widgets/forms/clothing_form.dart';
import 'package:picapool/widgets/forms/vehicle_form.dart';
import 'package:picapool/widgets/forms/furniture_form.dart';
import 'package:picapool/widgets/forms/others_form.dart';
import 'package:picapool/widgets/forms/sports_form.dart';

class SellForm extends StatefulWidget {

  const SellForm({super.key});

  @override
  _SellFormState createState() => _SellFormState();
}

class _SellFormState extends State<SellForm> {

  String? selectedCondition;

  List<File> _imageFiles = []; // Store cropped images

  // Functions
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
      androidUiSettings: const AndroidUiSettings(
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

  // common controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Map<String, TextEditingController> controllers = {
  'deviceType': TextEditingController(),
  'modelName': TextEditingController(),
  'brand': TextEditingController(),
  'accessories': TextEditingController(),
  'style': TextEditingController(),
  'fabric': TextEditingController(),
  'size': TextEditingController(),
  'type': TextEditingController(),
  'title': TextEditingController(),
  'author': TextEditingController(),
  'genre': TextEditingController(),
  // 'vehicleType': TextEditingController(),
  'year': TextEditingController(),
  'kmsDriven': TextEditingController(),
  'specs': TextEditingController(),
  // 'furnitureType': TextEditingController(),
  'material': TextEditingController(),
  'height': TextEditingController(),
  'length': TextEditingController(),
  'breadth': TextEditingController(),
};

List<String> imagesList = [];

  int currentCategory = 1;

  @override
  Widget build(BuildContext context) {


    final formController = Get.find<FormController>();


    final sellformKey = GlobalKey<FormState>();

    String categoryName = Get.arguments['categoryName'];

    setState(() {
      if(categoryName == 'electronics'){
      currentCategory = 1;
      } else if (categoryName == 'clothing') {
      currentCategory = 2;
      } else if (categoryName == 'sports') {
      currentCategory = 3;
      } else if (categoryName == 'furniture') {
      currentCategory = 4;
      } else if (categoryName == 'books') {
      currentCategory = 5;
      } else if (categoryName == 'vehicle') {
      currentCategory = 6;
      } else if (categoryName == 'other') {
      currentCategory = 7;
      }
    });

    return Scaffold(
      appBar: const LocationAppBar(hasBackRoute: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: sellformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ImagePickerWidget(imageFiles: imagesList,),
                const SizedBox(height: 16),
                    
                
                categoryName.trim().toLowerCase() == "electronics" ?
                  Column(
                    children: [
                      ElectronicsForm(
                        deviceTypeController: controllers['deviceType']!, 
                        modelNameController: controllers['modelName']!, 
                        brandController: controllers['brand']!, 
                        accessoriesController: controllers['accessories']!, 
                        descriptionController: _descriptionController, 
                        priceController: _priceController,
                        ),
                        ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )
                    ],
                  )
                : categoryName.trim().toLowerCase() == "clothing" ?
                Column(
                  children: [
                    ClothingForm(
                      styleController: controllers['style']!, 
                      brandController: controllers['brand']!, 
                      priceController: _priceController, 
                      fabricController: controllers['fabric']!, 
                      descriptionController: _descriptionController),
                      ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )
                  ],
                )
               : categoryName.trim().toLowerCase() == "sports" ?
                Column(
                  children: [
                    SportsForm(typeController: controllers['type']!, 
                    brandController: controllers['brand']!, 
                    priceController: _priceController, 
                    sizeController: controllers['size']!, 
                    descriptionController: _descriptionController),
                    ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )
                  ],
                )
               : categoryName.trim().toLowerCase() == "books" ?
                Column(
                  children: [
                    BooksForm(titleController: controllers['title']!, 
                    authorController: controllers['author']!, 
                    priceController: _priceController, 
                    genreController: controllers['genre']!, 
                    descriptionController: _descriptionController),
                    ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )
                  ],
                )
               : categoryName.trim().toLowerCase() == "vehicle" ?
                Column(
                  children: [
                    VehicleForm(
                      typeController: controllers['type']!, 
                      yearController: controllers['year']!, 
                      brandController: controllers['brand']!, 
                      kmsController: controllers['kmsDriven']!, 
                      specsController: controllers['specs']!, 
                      priceController: _priceController, 
                      descriptionController: _descriptionController),
                      ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )
                  ],
                )
               : categoryName.trim().toLowerCase() == "furniture" ? 
                Column(
                  children: [
                    FurnitureForm(
                      typeController: controllers['type']!, 
                    brandController: controllers['brand']!, 
                    priceController: _priceController, 
                    materialController: controllers['material']!, 
                    descriptionController: _descriptionController, 
                    lenghtController: controllers['length']!, breadthController: controllers['breadth']!, 
                    heightController: controllers['height']!),
                    ConditionChips(
                          category: categoryName.trim().toLowerCase(),
                          onConditionSelected: (value) {
                            setState(() {
                              selectedCondition = value;
                            });
                          },
                        selectedCondition: selectedCondition,
                        )

                  ],
                )
                : Column(
                  children: [
                    OtherForm(
                      nameController: _nameController, 
                      priceController: _priceController, 
                      descriptionController: _descriptionController
                      ),
                  ],
                ),
               
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed:  (){
                      if (sellformKey.currentState!.validate()) {
                        formController.saveFormOneData(saveFormData());
                        Get.toNamed(GetRoutes.sellProductsSecondFormPage);
                      } else {
                        showSnackBar(content: 'Please fill all the fields', context: context);
                      }
                      
                      }, 
                buttonLabel: 'Next')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> saveFormData() {
    Map<String, dynamic> formOneData = {};
    formOneData['category'] =   currentCategory;
    // formOneData['name'] = _nameController.text.toString() == "" ? null :  _nameController.text.toString()   ;
    formOneData['name'] = "productName";
    formOneData['price'] = _priceController.text.toString() == "" ? null : _priceController.text.toString()   ;
    formOneData['pic'] = imagesList ;
    formOneData['condition'] = selectedCondition;
    formOneData['partner'] = "1" ;
    formOneData['description'] = _descriptionController.text.toString() == "" ? null :  _descriptionController.text.toString()   ;
    formOneData['deviceType'] = controllers['deviceType']?.text.toString() == "" ? null : controllers['deviceType']?.text.toString()   ;
    formOneData['modelName'] = controllers['modelName']?.text.toString() == "" ? null : controllers['modelName']?.text.toString()   ;
    formOneData['brand'] = controllers['brand']?.text.toString() == "" ? null : controllers['brand']?.text.toString()   ;
    formOneData['accessories'] = controllers['accessories']?.text.toString() == "" ? null : controllers['accessories']?.text.toString()   ;
    formOneData['style'] = controllers['style']?.text.toString() == "" ? null : controllers['style']?.text.toString()   ;
    formOneData['fabric'] = controllers['fabric']?.text.toString() == "" ? null : controllers['fabric']?.text.toString()   ;
    formOneData['type'] = controllers['type']?.text.toString() == "" ? null : controllers['type']?.text.toString()   ;
    formOneData['size'] = controllers['size']?.text.toString() == "" ? null : controllers['size']?.text.toString()   ;
    // formOneData['title'] = controllers['title']?.text.toString() == "" ? null : controllers['title']?.text.toString()   ;
    formOneData['author'] = controllers['author']?.text.toString() == "" ? null : controllers['author']?.text.toString()   ;
    formOneData['genre'] = controllers['genre']?.text.toString() == "" ? null : controllers['genre']?.text.toString()   ;
    // formOneData['vehicleType'] = controllers['vehicleType']?.text.toString() == "" ? null : controllers['vehicleType']?.text.toString()   ;
    formOneData['year'] = controllers['year']?.text.toString() == "" ? null : controllers['year']?.text.toString()   ;
    formOneData['kmsDriven'] = controllers['kmsDriven']?.text.toString() == "" ? null : controllers['kmsDriven']?.text.toString()   ;
    formOneData['specifications'] = controllers['specs']?.text.toString() == "" ? null : controllers['specs']?.text.toString()   ;
    // formOneData['furnitureType'] = controllers['furnitureType']?.text.toString() == "" ? null : controllers['furnitureType']?.text.toString()   ;
    formOneData['material'] = controllers['material']?.text.toString() == "" ? null : controllers['material']?.text.toString()   ;
    formOneData['length'] = controllers['length']?.text.toString() == "" ? null : controllers['length']?.text.toString()   ;
    formOneData['breadth'] = controllers['breadth']?.text.toString() == "" ? null : controllers['breadth']?.text.toString()   ;
    formOneData['height'] = controllers['height']?.text.toString() == "" ? null : controllers['height']?.text.toString()   ;
    print(formOneData);
    return formOneData; // populated map
  }
}
