import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import '../screens/overview_screen.dart';
import '../utils/snackBar.dart';
import '../utils/dialogbox.dart';

class FireBaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Email sign in
  Future<String> userSignIn(String username, String email, String password,
      BuildContext context) async {
    String res = 'Some error has occurred';
    try {
      //email sign up the user in firebase
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(credential.user!.uid);

      await _auth.currentUser!.sendEmailVerification();

      // if(!_auth.currentUser!.emailVerified){
      //   Future.delayed(const Duration(seconds: 15)).then((_) =>
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (context) => const OverViewScreen()))
      //   );
      // }

      //set data in cloud fireStore
      await db.collection('user Signup').doc(credential.user!.uid).set(
        {
          'username': username,
          'email': email,
          'uid': credential.user!.uid,
        },
      );

      res = 'success';
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }

  //user login
  Future<String> userLogIn(String email, String password) async {
    String res = 'Some error has occurred';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        return res = 'Email verification sent';
      }

      res = 'successfully logged in';
    } catch (err) {
      res = err.toString();
      print(res);
    }
    return res;
  }

  //phone signIn
  Future<String> phoneSignIn(String phoneNumber, BuildContext context) async {
    TextEditingController codeController = TextEditingController();
    String res = 'Some error has occurred';
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          print(error.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          showOtpDialog(
            context,
            codeController,
            () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim());
              await _auth.signInWithCredential(credential);

              showContent(context);
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          null;
        },
      );

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  void showContent(BuildContext context) async {
    Navigator.of(context).pop();
    snackBar(context, 'OTP successfully verified');
    await Future.delayed(const Duration(seconds: 3)).then(
      (_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OverViewScreen(),
          ),
        );
        snackBar(context, 'Successfully logged in');
      },
    );
  }

  //google SigIn
  Future<String> googleSignIn(BuildContext context) async {
    String res = 'Some error Occurred';
    try {
      GoogleSignInAccount? signIn = await GoogleSignIn().signIn();
      GoogleSignInAuthentication signInAuth = await signIn!.authentication;
      print(signInAuth.accessToken);
      print(signInAuth.idToken);

      if (signInAuth.accessToken != null && signInAuth.idToken != null) {
        OAuthCredential cred = GoogleAuthProvider.credential(
          accessToken: signInAuth.accessToken,
          idToken: signInAuth.idToken,
        );

        await _auth.signInWithCredential(cred);
      }
      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //Anonymous signIn
  Future<void> anonymousSignIn() async {
    UserCredential credential = await _auth.signInAnonymously();

    print(credential.user!.email);
  }

  //user logOut
  userLogOut() async {
    await _auth.signOut();
  }
}
