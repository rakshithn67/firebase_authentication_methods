import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase/firebase_methods.dart';
import '../utils/snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_input_field.dart';
import '../screens/overview_screen.dart';

class UserLogInScreen extends StatefulWidget {
  const UserLogInScreen({Key? key}) : super(key: key);

  @override
  State<UserLogInScreen> createState() => _UserLogInScreenState();
}

class _UserLogInScreenState extends State<UserLogInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  logIn() async {
    String result = await FireBaseMethods()
        .userLogIn(emailController.text, passwordController.text);

    if (result == 'Email verification sent') {
      if (!_auth.currentUser!.emailVerified) {
        showSnackBar('Email verification sent');
        await Future.delayed(const Duration(seconds: 15)).then(
          (_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const OverViewScreen(),
              ),
            );
          },
        );
        showSnackBar('successfully logged in');
      }
    } else if (result == 'successfully logged in') {
      if (_auth.currentUser!.emailVerified) {
        showSnackBar('successfully logged in');
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OverViewScreen(),
          ),
        );
      }
    } else {
      print(result);
      showSnackBar(result);
    }

    // if (!_auth.currentUser!.emailVerified) {
    //   showSnackBar('Email verification sent');
    // }
    // //showSnackBar('successfully logged in');
    //
    // if (result == 'successfully logged in' ||
    //     result == 'Email verification sent') {
    //   // showSnackBar(result);
    //
    //   _auth.currentUser!.emailVerified
    //       ? await Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(
    //             builder: (context) => const OverViewScreen(),
    //           ),
    //         )
    //       : await Future.delayed(const Duration(seconds: 15)).then((_) {
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (context) => const OverViewScreen(),
    //             ),
    //           );
    //         });
    //
    //   //showSnackBar('Successfully logged in');
    // } else {
    //   print(result);
    //   showSnackBar(result);
    // }
  }

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
                'Log In',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
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
                  text: 'Log In',
                  onPressed: logIn,
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
