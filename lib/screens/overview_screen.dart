import 'package:flutter/material.dart';
import 'package:firebase_auth_complete/firebase/firebase_methods.dart';
import 'package:firebase_auth_complete/screens/home_screen.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  _logOut(BuildContext context) async {
    await FireBaseMethods().userLogOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SignIn / login success...',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () => _logOut(context),
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
