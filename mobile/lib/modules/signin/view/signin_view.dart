import 'package:flutter/material.dart';
import 'package:mobile/modules/signin/controller/signin_controller.dart';

class SignInView extends StatefulWidget {
  static const String routeName = '/sign-in-view';

  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController _signInController = SignInController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSignIn() async {
    _signInController.onSubmit(context);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _signInController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    controller: _signInController.emailController,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) =>
                        _signInController.emailValidator(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    controller: _signInController.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                    validator: (value) =>
                        _signInController.passwordValidator(value),
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    child: TextButton(
                      onPressed: () =>
                          _signInController.navigateToRegister(context),
                      child: const Text('Register'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _onSignIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
