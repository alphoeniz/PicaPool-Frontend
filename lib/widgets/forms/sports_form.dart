import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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
