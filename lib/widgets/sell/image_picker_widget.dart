import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  List<String> imageFiles;
  ImagePickerWidget({required this.imageFiles, super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

    int selectedConditionIndex = -1; // To keep track of selected condition



  Future<void> pickImage(List<String> imageURLs) async {
    
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        File? croppedImage = await _cropImage(File(image.path));
        final bytes = File(croppedImage!.path).readAsBytesSync();
        final base64Image = base64Encode(bytes);
        if (croppedImage != null) {
          setState(() {
            imageURLs.add(base64Image);
          });
        }
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.orange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
  
    return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          pickImage(widget.imageFiles);
                          } ,
                        child: widget.imageFiles.isEmpty
                            ? Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined, size: 60, color: Colors.orange),
                                    Text('Add image', style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: true,
                                  autoPlay: false,
                                ),
                                items: widget.imageFiles.map((image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.memory(
                                              base64Decode(image),
                                              width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: GestureDetector(
                                              onTap: ()=> pickImage(widget.imageFiles),
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.orange,
                                                child: Icon(Icons.add, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  );
  }
}