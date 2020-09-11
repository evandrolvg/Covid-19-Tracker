import 'dart:ui';
import 'package:covid_19/constant.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/Provider/api_data.dart';
import 'package:covid_19/Provider/country.dart';
import 'package:covid_19/data_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => allData()),
        ChangeNotifierProvider(create: (_) => SCountry())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVID-19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              body1: TextStyle(color: kBodyTextColor),
            )),
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(controller: controller, child: DataScreen()),
    );
  }
}
