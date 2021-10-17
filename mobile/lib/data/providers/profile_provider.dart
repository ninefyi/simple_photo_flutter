import 'dart:convert';

import 'package:mobile/data/models/photo/photo.dart';
import 'package:mobile/data/networks/api_service.dart';

class ProfileProvider {
  Future getPhotosByMemberId(String memberId) async {
    try {
      List<PhotoById> photosList = [];
      final response =
          await ApiService().getAllPhotos('/members/$memberId/photos');
      final jsonList = jsonDecode(response!.body);
      for (final item in jsonList) {
        photosList.add(PhotoById.fromJson(item));
      }
      return photosList;
    } catch (e) {
      print("ProfileProvider error: " + e.toString());
    }
  }
}
