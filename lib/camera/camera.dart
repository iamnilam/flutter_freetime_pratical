import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final imagePicker = ImagePicker();
  PickedFile? pickedFile;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My camera app"),
      ),
      body: Center(
        child: _image == null ? const Text("No Images") : Image.file(_image!),
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
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
      uploadImageToFirebase();
    }
  }

  Future<void> openGallery() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
      uploadImageToFirebase();
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_image == null) return;
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      final ref = storage.ref().child('images/${DateTime.now()}.png');
      await ref.putFile(_image!);
      final url = await ref.getDownloadURL();

      // Use the `url` for displaying or further processing
      print('File uploaded. Download URL: $url');
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      // Handle any errors that occur during the upload process
    }
  }
}
