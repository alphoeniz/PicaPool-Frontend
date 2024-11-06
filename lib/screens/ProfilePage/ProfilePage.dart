import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picapool/functions/auth/auth_controller.dart';
import 'package:picapool/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var user = authController.user.value;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1D0E61), // Dark blue background
      body: SafeArea(
        child: Column(
          children: [
            // Header section with profile picture, name, and other details
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => CreatePoolScreen()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Color(0xffFF8D41),
                    ),
                    child: const Text(
                      "Help",
                      style: TextStyle(
                        fontFamily: "MontserratSB",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: Image.asset(
                      'assets/icons/Frame 64.png', // Replace with your image
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            user.name ?? "",
                            style: const TextStyle(
                              fontFamily: "MontserratSB",
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "@${user.username ?? "nousername"}",
                          style: const TextStyle(
                            fontFamily: "MontserratR",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user.auth?.mobile ?? "",
                          style: const TextStyle(
                            fontFamily: "MontserratR",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showEditProfileModal(
                                    context, user); // Open bottom modal
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/Frame 153.png",
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontFamily: "MontserratM",
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.orange, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/Bell.png",
                              title: 'Notification Preferences',
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/History.png",
                              title: 'Pooling History',
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/Letter Opened.png",
                              title: 'Feedback Form',
                              onTap: () {
                                _showFeedbackModal(context); 
                              },
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/Group 59.png",
                              title: 'App Guide',
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/Frame 157.png",
                              title: 'Permissions',
                              onTap: () {
                                _showPermissionsModal(context); // Open permissions modal
                              },
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/File Text.png",
                              title: 'Privacy Policy',
                            ),
                            _buildOptionTile(
                              context,
                              imagePath: "assets/icons/Frame 59.png",
                              title: 'Logout',
                              onTap: () {
                                _showLogoutModal(context); 
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context,
      {required String imagePath, required String title, void Function()? onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          leading: Image.asset(
            imagePath, // Use the provided image path
            width: 28, // Adjust the size as needed
            height: 28,
          ),
          title: Text(
            title,
            style: TextStyle(fontFamily: "MontserratR", fontSize: 16),
          ),
          onTap: onTap,
        ),
        const Divider(
          color: Colors.grey, // Grey color divider
          thickness: 0.5,
          height: 2,
        ),
      ],
    );
  }

  void _showPermissionsModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // This makes modal full screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Edit your Preferences!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratSB",
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enable or Disable your settings",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: "MontserratR",
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffFFF7F3),
                  border: Border.all(color: Colors.orange, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildPermissionOption(Icons.location_on, "Location Access"),
                    const Divider(thickness: 1.5),
                    _buildPermissionOption(Icons.notifications, "Notifications"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPermissionOption(IconData icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "MontserratR",
              ),
            ),
          ],
        ),
        Icon(Icons.check_circle, color: Colors.green, size: 28),
      ],
    );
  }

  void _showEditProfileModal(BuildContext context, User user) {
    debugPrint(user.toJson().toString());
    _usernameController.text = user.username ?? "";
    _nameController.text = user.name ?? "";

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // This makes modal full screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9, // Initial height of modal
          maxChildSize: 0.9, // Max height of modal
          minChildSize: 0.6, // Min height of modal
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Profile Image with Edit Icon
                    SizedBox(height: 20,),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "MontserratSB",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Update Your Profile Information",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: "MontserratR",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          child: Image.asset(
                            'assets/icons/Frame 64.png', // Profile picture asset
                            width: 100,
                            height: 100,
                          ),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xffFF8D41),
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Profile Information Section with Orange Border
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.orange, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildTextField(
                              Icons.person, "Name", _nameController),
                          const Divider(thickness: 1.5),
                          _buildTextField(
                              Icons.info, "Username", _usernameController),
                          const Divider(thickness: 1.5),
                          _buildTextField(
                              Icons.phone, "Phone", _phoneController),
                          // const Divider(thickness: 1.5),
                          // _buildTextField(
                          //     Icons.email, "Email", "noemail@gmail.com"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Submit Button
                    ElevatedButton(
                      onPressed: () async {
                        var updatedValues = <String, String>{};
                        if (_nameController.text.isNotEmpty &&
                            _nameController.text != user.name) {
                          updatedValues["name"] = _nameController.text;
                        }
                        if (_usernameController.text.isNotEmpty &&
                            _usernameController.text != user.username) {
                          updatedValues["username"] = _usernameController.text;
                        }
                        if (_phoneController.text.isNotEmpty &&
                            _phoneController.text != user.auth?.mobile) {
                          updatedValues["phone"] = _phoneController.text;
                        }

                        if (updatedValues.isNotEmpty) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          await authController.updateUser(updatedValues);
                          if (context.mounted) {
                            Navigator.pop(context); // Close the loading dialog
                            Navigator.pop(context); // Close the modal
                            setState(() {});
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF8D41), // Orange background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: Size(double.infinity, 50), // Full width button
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white, // White text color
                          fontSize: 18,
                          fontFamily: "MontserratR",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Go Back Button
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey), // Grey outline
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        minimumSize: Size(double.infinity, 50), // Full width button
                      ),
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                          color: Colors.grey, // Grey text color
                          fontSize: 16,
                          fontFamily: "MontserratR",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: label,
        border: InputBorder.none, // No border since the container has a border
      ),
      controller: controller,
    );
  }


  void _showFeedbackModal(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true, // This makes modal full screen
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Help us Improve!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "MontserratSB",
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your Feedback is incredibly valuable",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "MontserratR",
              ),
            ),
            const SizedBox(height: 16),
            // Feedback TextField
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter your Feedback...",
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: "MontserratR"),
                  border: InputBorder.none, // No border since the container has a border
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Submit Form Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFF8D41), // Orange background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
              child: Text(
                "Submit Form",
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 18,
                  fontFamily: "MontserratR",
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Rate Us on Play Store Button
            OutlinedButton.icon(
              onPressed: () {
                // Handle Play Store rating action
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey), // Grey outline
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
              icon: Image.asset(
                'assets/icons/playstore.png', // Play Store icon asset
                width: 24,
                height: 24,
              ),
              label: Text(
                "Rate Us on Play Store",
                style: TextStyle(
                  color: Colors.grey, // Grey text color
                  fontSize: 16,
                  fontFamily: "MontserratR",
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  void _showLogoutModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // This makes modal full screen
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratSB",
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Do you really want to Log Out of your account?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: "MontserratR",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Log Out Button
              ElevatedButton(
                onPressed: () async {
                  await authController.logout();
                  if (context.mounted) {
                    Navigator.pop(context); // Close the modal
                  } // Add your logout functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xffFF8D41), // Orange background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  minimumSize:
                      const Size(double.infinity, 50), // Full width button
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white, // White text color
                    fontSize: 18,
                    fontFamily: "MontserratR",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Go Back Button
              OutlinedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey), // Grey outline
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  minimumSize:
                      const Size(double.infinity, 50), // Full width button
                ),
                child: const Text(
                  "Go Back",
                  style: TextStyle(
                    color: Colors.grey, // Grey text color
                    fontSize: 16,
                    fontFamily: "MontserratR",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
