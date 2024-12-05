import 'package:flutter/material.dart';
import 'package:picapool/widgets/sell/build_field.dart';

class DimensionsFields extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController breadthController;
  final TextEditingController lenghtController;
  const DimensionsFields({
    required this.breadthController,    
    required this.lenghtController,    
    required this.heightController,    
    super.key});

  @override
  State<DimensionsFields> createState() => _DimensionsFieldsState();
}

class _DimensionsFieldsState extends State<DimensionsFields> {
  String _selectedDimensionUnit = 'centimeters';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dimensions:',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontFamily: 'MontserratR',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDimensionUnit,
                      items:
                          ['centimeters', 'meters', 'feet', 'inch'].map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDimensionUnit = value!;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFA3A3A3),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF8D41),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      label: 'Height',
                      hintText: '12',
                      errorText: "This is a required field",
                      onEditingComplete: () {},
                      textEditingController: widget.heightController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildTextField(
                      label: 'Length',
                      hintText: '12',
                      errorText: "This is a required field",
                      onEditingComplete: () {},
                      textEditingController: widget.lenghtController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildTextField(
                      label: 'Breadth',
                      hintText: '12',
                      errorText: "This is a required field",
                      onEditingComplete: () {},
                      textEditingController: widget.breadthController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
