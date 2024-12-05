import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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
      
      buildTextField(label: "Device type", hintText: "Eg: Laptop, Smartphone", 
      errorText: "This is a required field", 
      onEditingComplete: (){},
      textEditingController: widget.deviceTypeController),
      const SizedBox(height: 8,),
      buildTextField(label: "Model Name", hintText: "The model name/number", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.modelNameController),
      const SizedBox(height: 8,),
      buildTextField(label: "Brand", hintText: "Eg: Samsung", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.brandController),
      const SizedBox(height: 8,),
      buildTextField(label: "Description", hintText: "The product details", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.descriptionController),
      const SizedBox(height: 8,),
      buildTextField(label: "Accessories Included", hintText: "Eg: charger, cable", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.accessoriesController),
      const SizedBox(height: 8,),
      buildTextField(label: "MRP", hintText: "Price", errorText: "This is a required field", onEditingComplete: (){}, textEditingController: widget.priceController),
    ],);
  }
}