// // ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:picapool/screens/location_fetch_screen.dart';
// import 'package:picapool/widgets/books/BooksPage2.dart';
// import 'package:picapool/screens/sell/select_category_page.dart';
// import 'package:picapool/widgets/Electronics/sell_confirmation_form_page.dart';

// import 'package:flutter/material.dart';

// class SellProductFormPage extends StatefulWidget {
//   const SellProductFormPage({super.key});

//   @override
//   State<SellProductFormPage> createState() => _SellProductFormPageState();
// }

// class _SellProductFormPageState extends State<SellProductFormPage> {
//   String currentLocation = "6th st, Connaught place, New Delhi, India";
//   List<XFile> _imageFiles = [];


//   void _updateLocation(String location) {
//     setState(() {
//       currentLocation = location;
//     });
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final List<XFile>? images = await _picker.pickMultiImage();
//     if (images != null) {
//       setState(() {
//         _imageFiles.addAll(images);
//       });
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//   final categoryName = Get.arguments['categoryName'];
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 50),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LocationScreen(),
//                           ),
//                         );
//                         if (result != null) {
//                           _updateLocation(result);
//                         }
//                       },
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             size: 35,
//                             color: Colors.black,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Row(
//                                 children: [
//                                   Text(
//                                     'Location',
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 20,
//                                     color: Colors.black,
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 currentLocation.length > 30
//                                     ? '${currentLocation.substring(0, 30)}...'
//                                     : currentLocation,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.black,
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: StepIndicator(currentStep: 2),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: _imageFiles.isEmpty
//                       ? SizedBox(
//                           height: 150,
//                           width: 150,
//                           child: Image.asset("assets/icons/upload_image.png"),
//                         )
//                       : Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: _imageFiles.map((image) {
//                             return Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: Image.file(
//                                     File(image.path),
//                                     width: 100,
//                                     height: 100,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 0,
//                                   right: 0,
//                                   child: IconButton(
//                                     icon: const Icon(
//                                       Icons.add_circle,
//                                       color: Colors.orange,
//                                     ),
//                                     onPressed: _pickImage,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: buildTextField(
//                   label: 'Title:', hintText: 'ABC'),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: buildTextField(label: 'Author', hintText: 'abc'),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: buildDropdownField(label: 'Genre', items: ['Fiction', 'Non-Fiction', 'Science', 'History']),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: buildTextField(
//                   label: 'Add description',
//                   hintText: 'e.g., laptop, smartphone',
//                   maxLength: 200),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: buildTextField(label: 'MRP', hintText: 'abc'),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ConditionOption(label: 'New', icon: Icons.new_label),
//                 ConditionOption(label: 'Used', icon: Icons.back_hand_rounded),
//                 ConditionOption(label: 'Overused', icon: Icons.warning_amber_rounded),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => BooksPage2()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xffFF8D41),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Next',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontFamily: "MontserratSB"),
//                       ),
//                       SizedBox(width: 10),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//       {required String label, required String hintText, int? maxLength}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(
//               color: Colors.black87,
//               fontSize: 16,
//               fontFamily: 'MontserratR',
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.transparent,
//             hintText: hintText,
//             hintStyle: const TextStyle(
//               color: Colors.grey,
//               fontFamily: 'MontserratR',
//               fontSize: 12,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFFFF8D41), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           ),
//           maxLength: maxLength,
//           style: const TextStyle(fontSize: 14, fontFamily: 'MontserratR'),
//         ),
//       ],
//     );
//   }

//   Widget buildDropdownField({required String label, required List<String> items}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontSize: 16,
//             fontFamily: 'MontserratR',
//           ),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.transparent,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFFA3A3A3), width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: const BorderSide(color: Color(0xFFFF8D41), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           ),
//           items: items.map((String item) {
//             return DropdownMenuItem<String>(
//               value: item,
//               child: Text(item),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {},
//         ),
//       ],
//     );
//   }
// }

// class ConditionOption extends StatelessWidget {
//   final String label;
//   final IconData icon;

//   ConditionOption({super.key, required this.label, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xffA3A3A3)),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       width: 100,
//       height: 100,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(icon, size: 60, color: const Color(0xffA3A3A3)),
//           Text(
//             label,
//             style: const TextStyle(
//                 fontFamily: "MontserratR", fontSize: 12, color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }