import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/widgets/nearby/login.dart';
import 'package:covid_19/widgets/nearby/registration.dart';
import 'package:covid_19/widgets/nearby/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/helper/api_covid.dart';
import 'package:covid_19/Provider/country.dart';
import 'package:covid_19/home_page.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllData()),
        ChangeNotifierProvider(create: (_) => SCountry()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVID-19 Tracker',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          // NearbyInterface.id: (context) => NearbyInterface(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    // Provider.of<dynamic>(context, listen: false);
    final liveCountry = Provider.of<AllData>(context, listen: false);
    final country = Provider.of<SCountry>(context, listen: false);

    Timer(Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();

      // if (pref == null || pref.getString('country') == null) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => ListCountry()));
      //   liveCountry.retriveAll();
      // } else {
      if (pref != null || pref.getString('country') != null) {
        country.setCountryName(pref.getString('country'));
        liveCountry.retrieveOne(country.countryName);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      liveCountry.retriveAll();
      // }
    });

    bool _checkLogin() {
      GoogleSignInAccount user = _googleSignIn.currentUser;
      return !(user == null && _auth.currentUser == null);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(0.0),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/images/covid.jpg'),
                fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: [
            Text(
              _checkLogin() ? 'Welcome ' + _auth.currentUser.email : '',
              style: TextStyle(
                  fontSize: 15,
                  backgroundColor: kTitleTextColor.withOpacity(.8),
                  color: kBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
