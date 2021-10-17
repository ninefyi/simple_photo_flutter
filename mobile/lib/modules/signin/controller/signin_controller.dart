import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/models/member/member.dart';
import 'package:mobile/data/providers/signin_provider.dart';
import 'package:mobile/modules/home/view/home_view.dart';
import 'package:mobile/modules/register/view/register_view.dart';
import 'package:mobile/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onChangeEmailText() {
    print(emailController.text);
  }

  void onChangePasswordText() {
    print(passwordController.text);
  }

  String? emailValidator(String? value) {
    final isEmail = Helper().emailValidate(value!);
    if (value.isEmpty || !isEmail) {
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

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await _onSignIn(context);
    }
  }

  Future _onSignIn(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final Map<String, String> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      final Member response = await SignInProvider().onSignIn(data);
      await prefs.setInt('memberId', response.id);
      await prefs.setBool('isLoggedIn', true);
      emailController.clear();
      passwordController.clear();
      _navigateToHome(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Cannot sign in please try again.'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeView.routeName);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterView.routeName);
  }
}
