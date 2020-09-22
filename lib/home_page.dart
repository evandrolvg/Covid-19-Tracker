import 'package:covid_19/views/info/live.dart';
import 'package:covid_19/views/about/info_screen.dart';
import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/widgets/nearby/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/views/news/newspage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  double offset = 0;
  TabController _tabController;

  @override
  void initState() {
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
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
      onWillPop: () async => true,
      // color: Colors.yellow,
      child: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
              physics: BouncingScrollPhysics(), controller: _tabController,
              // children: [LivePage(), NewsPage(), InfoScreen()]),
              children: [LivePage(), NewsPage(), WelcomeScreen()]),
          bottomNavigationBar: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.announcement),
              ),
              Tab(
                icon: Icon(Icons.info),
              ),
            ],
            labelColor: kTextLightColor,
            unselectedLabelColor: kPrimaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: kTitleTextColor,
          ),
          backgroundColor: kBackgroundColor,
        ),
      ),
    );
  }
}
