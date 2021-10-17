import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile/data/models/photo/photo.dart';
import 'package:mobile/data/networks/api_service.dart';

class HomeProvider {
  Future getImages() async {
    try {
      List<AllPhoto> photosList = [];
      // ------- use json -------
      final response = await ApiService().getAllPhotos('/photos');
      final jsonList = jsonDecode(response!.body);
      for (final item in jsonList) {
        photosList.add(AllPhoto.fromJson(item));
      }
      return photosList;
    } catch (e) {
      print(e);
    }
  }

  Future onUploadImage(FormData data) async {
    try {
      final response = await ApiService().onUploadPhotos('/photos', data);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
