import 'package:flutter/material.dart';

import '../screens/user_logIn_screen.dart';
import '../screens/anonymous_screen.dart';
import '../screens/google_sigin_screen.dart';
import '../screens/phone_login_screen.dart';
import '../screens/user_signIn_screen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //navigate to the signup screen
  navigateToSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserSignScreen(),
      ),
    );
  }

  //navigate to the login screen
  navigateToLogIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserLogInScreen(),
      ),
    );
  }

  //navigate to the phone signIn screen
  navigateToPhone() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PhoneLogScreen(),
      ),
    );
  }

//navigate to the google signIn screen
  navigateToGooglePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GoogleSignScreen(),
      ),
    );
  }

//navigate to the anonymous screen
  navigateAnonymousPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AnonymousScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
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
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Firebase Authentication Methods',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Email / Password Sign up',
                onPressed: navigateToSignIn,
              ),
              CustomButton(
                text: 'Email / Password Login',
                onPressed: navigateToLogIn,
              ),
              CustomButton(
                text: 'Phone Sign in',
                onPressed: navigateToPhone,
              ),
              CustomButton(
                text: 'Google Sign in',
                onPressed: navigateToGooglePage,
              ),
              CustomButton(
                text: 'Anonymous Sign in',
                onPressed: navigateAnonymousPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
