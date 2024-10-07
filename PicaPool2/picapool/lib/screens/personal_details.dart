import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picapool/screens/public_profile.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.of(context).pop(),
  ),
  centerTitle: true,
  title: Center(
    child: SizedBox(
      width: 100,
      child: StepProgressIndicator(
        totalSteps: 2,
        currentStep: 1,
        size: 4,
        padding: 8,
        selectedColor: Colors.orange,
        unselectedColor: Colors.grey[300]!,
      ),
    ),
  ),
  actions: <Widget>[
    // Creates an invisible IconButton to balance the AppBar visually
    IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.transparent),
      onPressed: () {},
    ),
  ],
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Personal Details',
                  style: TextStyle(
                    fontFamily: "MontserratR",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility_off, color: Colors.grey, size: 16),
                  SizedBox(width: 5),
                  Text(
                    'This is invisible for others',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'MontserratR',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildTextField('Add your full name*', _nameController, isName: true),
              SizedBox(height: 16),
              _buildPhoneField(),  // Phone field is optional now
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Add your age*', _ageController, isAge: true),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildGenderDropdown(),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isFormValid() ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PublicProfile()),
                  );
                } : null,
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid() ? Color(0xFFFF8D41) : Color(0xFFC2C2C2),
                  foregroundColor: _isFormValid() ? Colors.white : Color(0xFF626262),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isName = false, bool isAge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.split('*')[0],
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'MontserratR',
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isAge ? TextInputType.number : TextInputType.text, // Numeric keyboard for age field
          decoration: InputDecoration(
            filled: true,
            hintText: isName ? 'John Doe' : isAge ? '25' : '',
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFA3A3A3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFFF8D41), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          style: TextStyle(fontSize: 14),
          inputFormatters: [
            if (isName) ...[
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            ],
            if (isAge) ...[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Add Phone no.',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'MontserratR',
            ),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            hintText: '+1234567890',
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFA3A3A3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFFF8D41), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4.0, bottom: 4.0),
              child: ElevatedButton(
                onPressed: _phoneController.text.length == 10 ? () {
                  // Handle verify button press
                } : null,
                child: Text('Verify', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _phoneController.text.length == 10 ? Color(0xFFFF8D41) : Color(0xFFC2C2C2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(80, 30),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
          ),
          style: TextStyle(fontSize: 14),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (text) {
            setState(() {}); // To update the Verify button's state
          },
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Your gender',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontFamily: 'MontserratR',
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 48, // Match the height of other fields
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFA3A3A3), width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.grey, fontFamily: 'MontserratR', fontSize: 12),
                ),
              ),
              value: _selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      value,
                      style: TextStyle(fontFamily: 'MontserratR', fontSize: 12),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
           _ageController.text.isNotEmpty &&
           _selectedGender != null;
  }
}
