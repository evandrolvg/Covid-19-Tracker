import 'dart:async';
import 'dart:ui';
import 'package:covid_19/widgets/live.dart';
import 'package:covid_19/widgets/country.dart';
import 'package:covid_19/widgets/info.dart';
import 'package:covid_19/Provider/api_data.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/list_country.dart';
import 'package:covid_19/Provider/country.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  double offset = 0;
  String displayTitle = 'Live Tracker';
  Widget currentWidget = LivePage();
  List<String> title = ['Live Tracker', 'Country Tracker', 'Information'];
  List<Widget> widgets = [LivePage(), CountryPage(), InfoPage()];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    controller.addListener(onScroll);
    super.initState();
    _tabController = new TabController(initialIndex: 0, vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          displayTitle = title[_tabController.index];
          currentWidget = widgets[_tabController.index];
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(displayTitle),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.public),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListCountry()));
                    })
              ],
              centerTitle: true,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colors.blue, Colors.purple]))),
              bottom: TabBar(controller: _tabController, tabs: [
                Tab(
                  icon: Icon(Icons.live_tv),
                ),
                Tab(
                  icon: Icon(Icons.account_balance),
                ),
                Tab(
                  icon: Icon(Icons.info),
                ),
              ]),
            ),
            body: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [LivePage(), CountryPage(), InfoPage()])),
      ),
    );
  }
}
