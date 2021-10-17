import 'package:mobile/data/networks/api_service.dart';

class RegisterProvider {
  final ApiService _apiServices = ApiService();

  Future onCreateMember(Map<String, String> data) async {
    try {
      final response = await _apiServices.onCreateMember('/members', data);
      final res = response!.body;
      print("res: " + res.toString());
      return res;
    } catch (e) {
      print("Error provider: " + e.toString());
    }
  }
}
