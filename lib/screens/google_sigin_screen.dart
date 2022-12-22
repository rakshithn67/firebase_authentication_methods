import 'package:flutter/material.dart';

import '../utils/snackBar.dart';
import '../firebase/firebase_methods.dart';
import '../screens/overview_screen.dart';

class GoogleSignScreen extends StatefulWidget {
  const GoogleSignScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignScreen> createState() => _GoogleSignScreenState();
}

class _GoogleSignScreenState extends State<GoogleSignScreen> {
  googleSign() async {
    String result = await FireBaseMethods().googleSignIn(context);

    if (result == 'success') {
      showSnackBar('Signed in successfully');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OverViewScreen()));
    } else {
      showSnackBar(result);
    }
  }

  showSnackBar(String content) {
    snackBar(context, content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Google Login',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  // minWidth: 200,
                  padding: const EdgeInsets.all(8),
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  onPressed: googleSign,
                  child: Container(
                    width: 290,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Sign in with google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
