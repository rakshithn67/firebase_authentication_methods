import 'package:flutter/material.dart';

import '../utils/snackBar.dart';
import '../widgets/custom_button.dart';
import '../firebase/firebase_methods.dart';
import '../screens/overview_screen.dart';

class AnonymousScreen extends StatefulWidget {
  const AnonymousScreen({Key? key}) : super(key: key);

  @override
  State<AnonymousScreen> createState() => _AnonymousScreenState();
}

class _AnonymousScreenState extends State<AnonymousScreen> {
  void anonymousSign() async {
    await FireBaseMethods().anonymousSignIn();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OverViewScreen()));
    snackBar(context, 'Successfully logged in');
  }

  _logOut() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Anonymous Login',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Anonymous SignIn',
                onPressed: anonymousSign,
              ),
              CustomButton(
                text: 'Back',
                onPressed: _logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
