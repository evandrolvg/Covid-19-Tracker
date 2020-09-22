import 'package:covid_19/widgets/nearby/components/rounded_button.dart';
import 'package:covid_19/widgets/nearby/constants.dart';
import 'package:covid_19/widgets/nearby/nearby_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = auth.FirebaseAuth.instance;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
  }

  Future<String> signIn(String email, String password) async {
    auth.User user;
    String errorMessage;

    // if (email == null && password == null) {
    //   Fluttertoast.showToast(
    //       msg: 'sadsad',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }

    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
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
    TextEditingController emailTxtController = TextEditingController()
      ..text = 'teste@teste.com.br';

    TextEditingController passTxtController = TextEditingController()
      ..text = 'testeteste';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/covid.jpg'),
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
                  controller: emailTxtController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: passTxtController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.deepPurpleAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      if (email != null && password != null) {
                        final user = await signIn(email, password);
                        if (user != null) {
                          Navigator.pushNamed(context, NearbyInterface.id);
                        }

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
