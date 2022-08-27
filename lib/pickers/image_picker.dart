import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//guna stateful sbb perlu update some state sbb kita nak
//preview image

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _previewImage;
  //function untuk pick image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // final XFile? camera = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _previewImage = File(image?.path ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Image Avatar
        CircleAvatar(
          radius: 40,
          backgroundImage:
              //jika preview image tidak null preview gambar kalo tidak takde gambar preview
              _previewImage != null ? FileImage(_previewImage!) : null,
        ),

        //combine text and camera icon
        //upload image
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
