// widgets/category_form_widget.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picapool/screens/sell/config/category_config.dart';
import 'package:picapool/widgets/location_bar.dart';
import 'package:picapool/widgets/sell/build_field.dart';
import 'package:picapool/widgets/sell/dimensions_fields.dart';
import 'package:picapool/widgets/sell/image_picker_widget.dart';

class SellForm extends StatefulWidget {
  final bool enableElectronicsFields;
  final bool enableClothingFields;
  final bool enableSportsFields;
  final bool enableBooksFields;
  final bool enableVehicleFields;
  final bool enableFurnitureFields;

  const SellForm(
      {required this.enableElectronicsFields,
      required this.enableClothingFields,
      required this.enableSportsFields,
      required this.enableBooksFields,
      required this.enableVehicleFields,
      required this.enableFurnitureFields,
      super.key});

  @override
  _SellFormState createState() => _SellFormState();
}

class _SellFormState extends State<SellForm> {
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
  'vehicleType': TextEditingController(),
  'year': TextEditingController(),
  'kmsDriven': TextEditingController(),
  'specs': TextEditingController(),
  'furnitureType': TextEditingController(),
  'material': TextEditingController(),
  'height': TextEditingController(),
  'length': TextEditingController(),
  'breadth': TextEditingController(),
};

List<File> imagesList = [];


  @override
  Widget build(BuildContext context) {
    final String categoryName = Get.arguments['categoryName'];
    return Scaffold(
      appBar: AppBar(title: const Text('Category Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LocationBar(),
            const SizedBox(height: 16),
            ImagePickerWidget(imageFiles: imagesList,),
            const SizedBox(height: 16),

            
            categoryName.trim().toLowerCase() == "electronics" ?
              ElectronicsForm(
                deviceTypeController: controllers['deviceType']!, 
                modelNameController: controllers['modelName']!, 
                brandController: controllers['brand']!, 
                accessoriesController: controllers['accessories']!, 
                descriptionController: _descriptionController, 
                priceController: _priceController,
                )
            : categoryName.trim().toLowerCase() == "clothing" ?
            ClothingForm(
              styleController: controllers['style']!, 
              brandController: controllers['brand']!, 
              priceController: _priceController, 
              fabricController: controllers['fabric']!, 
              descriptionController: _descriptionController,
              )
           : categoryName.trim().toLowerCase() == "sports" ?
            SportsForm(typeController: controllers['type']!, 
            brandController: controllers['brand']!, 
            priceController: _priceController, 
            sizeController: controllers['size']!, 
            descriptionController: _descriptionController)
           : categoryName.trim().toLowerCase() == "books" ?
            BooksForm(titleController: controllers['title']!, 
            authorController: controllers['author']!, 
            priceController: _priceController, 
            genreController: controllers['genre']!, 
            descriptionController: _descriptionController)
           : categoryName.trim().toLowerCase() == "vehicle" ?
            VehicleForm(
              typeController: controllers['vehicleType']!, 
              yearController: controllers['year']!, 
              brandController: controllers['brand']!, 
              kmsController: controllers['kmsDriven']!, 
              specsController: controllers['specs']!, 
              priceController: _priceController, 
              descriptionController: _descriptionController)
           : categoryName.trim().toLowerCase() == "furniture" ? 
            FurnitureForm(
              typeController: controllers['furnitureType']!, 
            brandController: controllers['brand']!, 
            priceController: _priceController, 
            materialController: controllers['material']!, 
            descriptionController: _descriptionController, 
            lenghtController: controllers['length']!, breadthController: controllers['breadth']!, 
            heightController: controllers['height']!)
            : OtherForm(
              nameController: _nameController, 
              priceController: _priceController, 
              descriptionController: _descriptionController
              ),
           
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ElectronicsForm extends StatefulWidget {
  final TextEditingController deviceTypeController;
  final TextEditingController modelNameController;
  final TextEditingController brandController;
  final TextEditingController descriptionController;
  final TextEditingController accessoriesController;
  final TextEditingController priceController;
  const ElectronicsForm({
    required this.deviceTypeController,
    required this.modelNameController,
    required this.brandController,
    required this.accessoriesController,
    required this.descriptionController,
    required this.priceController,
    super.key});

  @override
  State<ElectronicsForm> createState() => _ElectronicsFormState();
}

class _ElectronicsFormState extends State<ElectronicsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Device type", 
        hintText: "Eg: Laptop, Smartphone", 
        errorText: "This is a required field", onEditingComplete: (){},
         textEditingController: widget.deviceTypeController),
      buildTextField(
        label: "Model Name", hintText: "The model name/number", 
        errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.modelNameController),
      buildTextField(label: "Brand", hintText: "Eg: Samsung", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.brandController),
      buildTextField(label: "Description", hintText: "The product details", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.descriptionController),
      buildTextField(label: "Accessories Included", hintText: "Eg: charger, cable", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.accessoriesController),
      buildTextField(label: "MRP", hintText: "Price", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.priceController),
    ],);
  }
}
class ClothingForm extends StatefulWidget {
  final TextEditingController styleController;
  final TextEditingController fabricController;
  final TextEditingController brandController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  const ClothingForm({
    required this.styleController,
    required this.brandController,
    required this.priceController,
    required this.fabricController,
    required this.descriptionController,
    super.key});

  @override
  State<ClothingForm> createState() => ClothingFormState();
}

class ClothingFormState extends State<ClothingForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Style", 
        hintText: "Eg: Tshirt, Trousers", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.styleController),
      buildTextField(
        label: "Fabric", 
        hintText: "Eg: Cotton", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.fabricController),
      buildTextField(
        label: "Brand", 
        hintText: "Eg: Levis", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.brandController),
      buildTextField(
        label: "Description", 
        hintText: "The product details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),
      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}

class SportsForm extends StatefulWidget {
  final TextEditingController typeController;
  final TextEditingController sizeController;
  final TextEditingController brandController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  const SportsForm({
    required this.typeController,
    required this.brandController,
    required this.priceController,
    required this.sizeController,
    required this.descriptionController,
    super.key});

  @override
  State<SportsForm> createState() => SportsFormState();
}

class SportsFormState extends State<SportsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Type of Product", 
        hintText: "Eg: Ball, Bat", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.typeController),
      buildTextField(
        label: "Size", 
        hintText: "Eg: 10inch", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.sizeController),
      buildTextField(
        label: "Brand", 
        hintText: "Eg: Levis", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.brandController),
      buildTextField(
        label: "Description", 
        hintText: "The product details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),
      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}

class BooksForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController genreController;
  final TextEditingController authorController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  const BooksForm({
    required this.titleController,
    required this.authorController,
    required this.priceController,
    required this.genreController,
    required this.descriptionController,
    super.key});

  @override
  State<BooksForm> createState() => BooksFormState();
}

class BooksFormState extends State<BooksForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Title", 
        hintText: "Eg: IKIGAI", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.titleController),
      buildTextField(
        label: "Genre", 
        hintText: "Eg: Non Fiction", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.genreController),
      buildTextField(
        label: "Author", 
        hintText: "Eg: Amish", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.authorController),
      buildTextField(
        label: "Description", 
        hintText: "The book details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),
      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}
class VehicleForm extends StatefulWidget {
  final TextEditingController typeController;
  final TextEditingController yearController;
  final TextEditingController brandController;
  final TextEditingController kmsController;
  final TextEditingController specsController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  const VehicleForm({
    required this.typeController,
    required this.yearController,
    required this.brandController,
    required this.kmsController,
    required this.specsController,
    required this.priceController,
    required this.descriptionController,
    super.key});

  @override
  State<VehicleForm> createState() => VehicleFormState();
}

class VehicleFormState extends State<VehicleForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Type", 
        hintText: "Eg: Bike, Scooty", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.typeController),
      buildTextField(
        label: "Year", 
        hintText: "Purchase year", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.yearController),
      buildTextField(
        label: "Brand", 
        hintText: "Eg: Honda", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.brandController),
      buildTextField(
        label: "KMs Driven", 
        hintText: "Eg: 12000", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.kmsController),
      buildTextField(
        label: "Specifications", 
        hintText: "Vehicle specifications", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.specsController),
      buildTextField(
        label: "Description", 
        hintText: "The book details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),
      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}
class FurnitureForm extends StatefulWidget {
  final TextEditingController typeController;
  final TextEditingController materialController;
  final TextEditingController brandController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController lenghtController;
  final TextEditingController breadthController;
  final TextEditingController heightController;
  const FurnitureForm({
    required this.typeController,
    required this.brandController,
    required this.priceController,
    required this.materialController,
    required this.descriptionController,
    required this.lenghtController,
    required this.breadthController,
    required this.heightController,
    super.key});

  @override
  State<FurnitureForm> createState() => FurnitureFormState();
}

class FurnitureFormState extends State<FurnitureForm> {

  

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Type", 
        hintText: "Eg: chair, desk", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.typeController),
      buildTextField(
        label: "Material", 
        hintText: "Eg: Wood, plastic", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.materialController),
      buildTextField(
        label: "Brand", 
        hintText: "Eg: Godrej", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.brandController),
      buildTextField(
        label: "Description", 
        hintText: "The item details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),
      DimensionsFields(breadthController: widget.breadthController , lenghtController: widget.lenghtController , heightController: widget.heightController )  ,
      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}
class OtherForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  const OtherForm({
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    super.key});

  @override
  State<OtherForm> createState() => OtherFormState();
}

class OtherFormState extends State<OtherForm> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildTextField(
        label: "Name", 
        hintText: "Name of the product", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.nameController),

      buildTextField(
        label: "Description", 
        hintText: "The book details", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.descriptionController),

      buildTextField(
        label: "MRP", 
        hintText: "Price", 
        errorText: "This is a required field", 
        onEditingComplete: (){}, 
        textEditingController: widget.priceController),
    ],);
  }
}