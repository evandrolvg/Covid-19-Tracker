import 'dart:async';
import 'dart:ui';
import 'package:covid_19/widgets/list_country.dart';
import 'package:covid_19/constant.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/Provider/api_data.dart';
import 'package:covid_19/Provider/country.dart';
import 'package:covid_19/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllData()),
        ChangeNotifierProvider(create: (_) => SCountry()),
        // ChangeNotifierProvider(create: (_) => NewsArticleListViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVID-19',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Covid 19',
    //   theme: ThemeData(
    //       scaffoldBackgroundColor: kBackgroundColor,
    //       fontFamily: "Poppins",
    //       textTheme: TextTheme(
    //         body1: TextStyle(color: kBodyTextColor),
    //       )),
    //   home: HomeScreen(),
    // );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final liveCountry = Provider.of<AllData>(context, listen: false);
    final country = Provider.of<SCountry>(context, listen: false);
    Timer(Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('country') == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListCountry()));
        liveCountry.retriveAll();
      } else {
        country.setCountryName(pref.getString('country'));
        liveCountry.retrieveOne(country.countryName);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        liveCountry.retriveAll();
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                margin: EdgeInsets.all(5.0),
                height: 125.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            ExactAssetImage('assets/images/splashscreen.jpeg'),
                        fit: BoxFit.fill)),
                child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 2.0))),
          ),
          SizedBox(height: 50.0),
          Container(
              child: Text(
            'v 1.0.0',
            style: TextStyle(fontWeight: FontWeight.w300),
          )),
        ],
      ),
    );
  }
}
