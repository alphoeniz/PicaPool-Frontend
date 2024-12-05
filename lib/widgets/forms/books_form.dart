import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

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