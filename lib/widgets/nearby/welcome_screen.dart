import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/widgets/nearby/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'registration.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/covidBack.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 48.0,
          ),
          RoundedButton(
            title: 'Log In',
            colour: kPrimaryColor,
            onPressed: () {
              // Navigator.pushNamed(context, LoginScreen.id);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
            },
          ),
          RoundedButton(
            title: 'Register',
            colour: kSecondaryColor,
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
