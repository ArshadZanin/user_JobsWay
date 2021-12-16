import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<File?> pickImage({
  required Future<File?> Function(File file) cropImage,
}) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage == null) return null;
    if(cropImage == null){
      return File(pickedImage.path);
    }else{
      final file = File(pickedImage.path);
      return cropImage(file);
    }
  }
}