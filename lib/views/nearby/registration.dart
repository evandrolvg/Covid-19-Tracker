import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/views/nearby/components/rounded_button.dart';
import 'package:covid_19/home_page.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  String email;
  String password;
  String userName;

  @override
  Widget build(BuildContext context) {
    // TextEditingController userTxtController = TextEditingController()
    //   ..text = 'teste';
    // TextEditingController emailTxtController = TextEditingController()
    //   ..text = 'teste@teste.com.br';
    // TextEditingController passTxtController = TextEditingController()
    //   ..text = 'testeteste';

    return Scaffold(
      backgroundColor: Colors.white,
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
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Register',
                  colour: kPrimaryColor,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if (newUser != null) {
                        _firestore.collection('users').doc(email).set({
                          'username': userName,
                          'infected': false,
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                        // Navigator.pushNamed(context, NearbyInterface.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      showToast(e.toString());
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
