import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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