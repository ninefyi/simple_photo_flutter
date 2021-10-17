import 'dart:convert';

import 'package:mobile/data/models/member/member.dart';
import 'package:mobile/data/networks/api_service.dart';

class SignInProvider {
  final ApiService _apiServices = ApiService();

  Future onSignIn(Map<String, String> data) async {
    try {
      final response = await _apiServices.onSignIn('/members/signin', data);
      final res = response!.body;

      final Map<String, dynamic> results = json.decode(res);
      final Member member = Member.fromJson(results);
      return member;
    } catch (e) {
      print("SignInProvider ===> " + e.toString());
    }
  }
}
