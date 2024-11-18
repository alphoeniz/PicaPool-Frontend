import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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