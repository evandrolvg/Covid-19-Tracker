import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/views/nearby/components/rounded_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool showSpinner = false;
  final _auth = auth.FirebaseAuth.instance;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {});
  }

  Future<String> signIn(String email, String password) async {
    auth.User user;
    String errorMessage;

    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      if (user != null) {
        Phoenix.rebirth(context);
      }
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    if (errorMessage != null) {
      showToast(errorMessage);
      return Future.error(errorMessage);
    }

    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/covidBack.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 8.0,
                ),
                RoundedButton(
                  title: 'Send email',
                  colour: kPrimaryColor,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      if (email != null) {
                        await _auth.sendPasswordResetEmail(email: email);
                        showToast('Email sent, check your email.');

                        setState(() {
                          showSpinner = false;
                        });
                      } else {
                        showToast('Invalid email or password');
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      showToast(e);
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
