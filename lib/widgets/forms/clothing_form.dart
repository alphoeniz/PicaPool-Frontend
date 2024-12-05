import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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