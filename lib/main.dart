import 'dart:async';
import 'package:covid_19/widgets/list_country.dart';
import 'package:covid_19/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/helper/api_covid.dart';
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
        title: 'COVID-19 Tracker',
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<dynamic>(context, listen: false);
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
      body: Container(
          margin: EdgeInsets.all(0.0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/covid.jpg'),
                  fit: BoxFit.fill))),
    );
  }
}
