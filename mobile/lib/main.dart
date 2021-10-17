import 'package:flutter/material.dart';
import 'package:mobile/modules/home/view/home_view.dart';
import 'package:mobile/modules/profile/view/profile_view.dart';
import 'package:mobile/modules/register/view/register_view.dart';
import 'package:mobile/modules/signin/view/signin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn');

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: isLoggedIn == true ? HomeView() : SignInView(),
    routes: {
      SignInView.routeName: (ctx) => SignInView(),
      HomeView.routeName: (ctx) => HomeView(),
      ProfileView.routeName: (ctx) => ProfileView(),
      RegisterView.routeName: (ctx) => RegisterView(),
    },
  ));
}
