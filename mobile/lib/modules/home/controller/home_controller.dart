import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/data/models/photo/photo.dart';
import 'package:mobile/data/providers/home_provider.dart';
import 'package:mobile/modules/profile/view/profile_view.dart';
import 'package:dio/dio.dart' as form;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  final HomeProvider _homeProvider = HomeProvider();

  Future getAllPhotos() async {
    try {
      final response = await _homeProvider.getImages();
      return response;
    } catch (error) {
      return <AllPhoto>[];
    }
  }

  void navigateToProfile(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileView.routeName);
  }

  Future<form.MultipartFile> _generateImageFromPath(String path) async {
    return await form.MultipartFile.fromFile(path,
        filename: path, contentType: new MediaType('image', 'jpeg'));
  }

  Future onUploadImage(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final memberId = prefs.getInt('memberId');
      final ImagePicker _picker = ImagePicker();
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 250,
        maxHeight: 250,
        imageQuality: 100,
      );
      if (pickedImage != null) {
        // final pickedImageFile = File(pickedImage.path);
        final formData = form.FormData.fromMap({
          'memberId': memberId,
          'photos_file': await _generateImageFromPath(pickedImage.path),
        });
        await _homeProvider.onUploadImage(formData);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Upload success.'),
          duration: const Duration(seconds: 1),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Cannot upload please try again.'),
        duration: const Duration(seconds: 1),
      ));
    }
  }
}
