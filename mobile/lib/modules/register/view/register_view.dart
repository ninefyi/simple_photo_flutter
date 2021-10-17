import 'package:flutter/material.dart';
import 'package:mobile/modules/register/controller/register_controller.dart';
import 'package:mobile/modules/signin/view/signin_view.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController _registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _registerController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: ValueKey('name'),
                        controller: _registerController.nameController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          icon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                            _registerController.nameValidator(value),
                      ),
                      TextFormField(
                        key: ValueKey('email'),
                        controller: _registerController.emailController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                        ),
                        validator: (value) =>
                            _registerController.emailValidator(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        key: ValueKey('password'),
                        controller: _registerController.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                        ),
                        validator: (value) =>
                            _registerController.passwordValidator(value),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        key: ValueKey('confirmPassword'),
                        controller:
                            _registerController.confirmedPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          icon: Icon(Icons.lock),
                        ),
                        validator: (value) =>
                            _registerController.confirmPasswordValidator(value),
                        onSaved: (value) {},
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor,
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () =>
                              _registerController.onCreateMember(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
