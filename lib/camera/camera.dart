import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:image_picker/image_picker.dart';

class Camera_Screen extends StatefulWidget {
  const Camera_Screen({Key? key}) : super(key: key);

  @override
  State<Camera_Screen> createState() => _Camera_ScreenState();
}

class _Camera_ScreenState extends State<Camera_Screen> {
  final imagePicker = ImagePicker();
  PickedFile? pickedFile;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My camera app"),
      ),
      body: Center(
        child: _image == null ? Text("No Images") : Image.file(_image!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: openCamera,
            tooltip: 'Take a Photo',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: openGallery,
            tooltip: 'Pick from Gallery',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }

  Future<void> openCamera() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile!.path);
      }
    });
  }

  Future<void> openGallery() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile!.path);
      }
    });
  }
}
