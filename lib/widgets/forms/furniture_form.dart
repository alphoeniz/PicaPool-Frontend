import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';
import 'package:picapool/widgets/sell/dimensions_fields.dart';

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