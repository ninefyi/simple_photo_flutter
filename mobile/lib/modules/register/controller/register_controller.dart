import 'package:flutter/material.dart';
import 'package:mobile/data/providers/register_provider.dart';
import 'package:mobile/utils/helper.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();
  final nameController = TextEditingController();

  String? emailValidator(String? value) {
    final isEmail = Helper().emailValidate(value!);
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!isEmail) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty || value.length < 7) {
      return 'Password must be least 7 characters long.';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Password do not match.';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a valid name';
    }
    return null;
  }

  void onCreateMember(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await _onCreateMember(context);

      Navigator.of(context).pop();
    }
  }

  Future _onCreateMember(BuildContext context) async {
    try {
      final Map<String, String> data = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };
      await RegisterProvider().onCreateMember(data);
      emailController.clear();
      passwordController.clear();
      confirmedPasswordController.clear();
      nameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Cannot register please try again.'),
        duration: const Duration(seconds: 1),
      ));
    }
  }
}
