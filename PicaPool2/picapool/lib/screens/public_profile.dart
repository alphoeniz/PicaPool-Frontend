import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:picapool/screens/home_screen.dart';
import 'package:picapool/widgets/bottom_navbar/common_bottom_navbar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({Key? key}) : super(key: key);

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;
  bool _isUsernameValid = true; // Validation flag for username

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onUsernameChanged);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_onUsernameChanged);
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    setState(() {
      _isUsernameValid = _usernameController.text.isNotEmpty &&
          RegExp(r'^[a-zA-Z0-9@._-]+$').hasMatch(_usernameController.text);
    });
  }

  bool get _isFinishButtonActive => _usernameController.text.isNotEmpty;

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
              currentStep: 2,
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
                  'Your Public Profile',
                  style: TextStyle(
                    fontFamily: "MontserratR",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? Image.asset("assets/icons/Profile.png")
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Add Profile Image',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'MontserratR',
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildTextField(
                'Add your username*',
                _usernameController,
                maxLength: 16,
                isUsername: true, // Specific for username field
              ),
              SizedBox(height: 16),
              _buildTextField('Add bio', _bioController,
                  maxLength: 200, maxLines: 3),
              SizedBox(height: 10),
              Text(
                'Users with bio receive up to 152% more pooling matches',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'MontserratR',
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isFinishButtonActive
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewBottomBar(),
                          ),
                        );
                      }
                    : null,
                child: Text('Finish', style: TextStyle(fontFamily: "MontserratR"),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFinishButtonActive
                      ? Color(0xFFFF8D41)
                      : Color(0xFFC2C2C2),
                  foregroundColor: _isFinishButtonActive
                      ? Colors.white
                      : Color(0xFF626262),
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

  Widget _buildTextField(
      String label, TextEditingController controller,
      {int? maxLength, int maxLines = 1, bool isUsername = false}) {
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
              if (label.contains('*'))
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
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: maxLines > 1
                ? 'Tell us about yourself'
                : 'Username',
            hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'MontserratR',
                fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFA3A3A3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isUsernameValid || !isUsername ? Color(0xFFFF8D41) : Colors.red,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
          ),
          style: TextStyle(fontSize: 14),
          onChanged: isUsername ? (value) {
            setState(() {
              _isUsernameValid = RegExp(r'^[a-zA-Z0-9@._-]+$').hasMatch(value);
            });
          } : null,
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
      );
      if (croppedFile != null) {
        setState(() {
          _profileImage = File(croppedFile.path);
        });
      }
    }
  }
}
