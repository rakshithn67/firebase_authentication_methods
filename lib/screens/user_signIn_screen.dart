import 'dart:async';

import 'package:flutter/material.dart';

import '../firebase/firebase_methods.dart';
import '../utils/snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_input_field.dart';
import '../screens/overview_screen.dart';

class UserSignScreen extends StatefulWidget {
  const UserSignScreen({Key? key}) : super(key: key);

  @override
  State<UserSignScreen> createState() => _UserSignScreenState();
}

class _UserSignScreenState extends State<UserSignScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showSnackBar(String content) {
    snackBar(context, content);
  }

  _logOut() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.deepOrangeAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                textField: 'username',
                controller: usernameController,
                isPassword: false,
                textInputType: TextInputType.text,
              ),
              TextInputField(
                textField: 'email',
                controller: emailController,
                isPassword: false,
                textInputType: TextInputType.emailAddress,
              ),
              TextInputField(
                textField: 'password',
                controller: passwordController,
                isPassword: true,
                textInputType: TextInputType.text,
              ),
              Container(
                width: double.infinity,
                child: CustomButton(
                  text: 'Sign up',
                  onPressed: () async {
                    String result = await FireBaseMethods().userSignIn(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                      context,
                    );

                    showSnackBar('Email verification sent');

                    if (result == 'success') {
                      await Future.delayed(const Duration(seconds: 15)).then(
                        (_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const OverViewScreen(),
                            ),
                          );
                        },
                      );

                      showSnackBar('Successfully signed in');
                    } else {
                      print(result);
                      showSnackBar(result);
                    }
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: CustomButton(
                  text: 'Back',
                  onPressed: _logOut,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
