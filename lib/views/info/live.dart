import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/helper/api_covid.dart';
import 'package:provider/provider.dart';
import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/views/info/my_header.dart';
import 'package:covid_19/views/info/counter.dart';
import 'package:covid_19/views/info/counter_min.dart';
import 'package:covid_19/views/info/infocard.dart';
import 'package:covid_19/views/info/chart_radial.dart';
import 'package:covid_19/widgets/list_country.dart';

// import 'package:covid_19/widgets/goomap.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  //SCROLL
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
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
    final liveCountry = Provider.of<AllData>(context);
    double perCritActiv = liveCountry.oneResponse != null
        ? (liveCountry.oneResponse.data['critical'] /
                liveCountry.oneResponse.data['cases']) *
            100
        : 0;
    double perActivTotal = liveCountry.oneResponse != null
        ? (liveCountry.oneResponse.data['active'] /
                liveCountry.oneResponse.data['cases']) *
            100
        : 0;

    double taxMort = liveCountry.oneResponse != null
        ? (liveCountry.oneResponse.data['deaths'] /
                liveCountry.oneResponse.data['cases']) *
            100
        : 0;

    double taxRec = liveCountry.oneResponse != null
        ? (liveCountry.oneResponse.data['recovered'] /
                liveCountry.oneResponse.data['cases']) *
            100
        : 0;

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: liveCountry.oneResponse == null ||
                liveCountry.oneResponse.data['code'] == 404 ||
                liveCountry.oneResponse.data['country'] == null
            ? Column(
                children: <Widget>[
                  //-----------------------------HEADER-----------------------------
                  MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    textTop: "All you need",
                    textBottom: "is stay at home.",
                    offset: offset,
                    imageDecoration: true,
                  ),
                  //-----------------------------SELECT COUNTRY-----------------------------
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        CircularProgressIndicator();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListCountry()));
                      },
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                            Text(
                              'Select country',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: <Widget>[
                      // CircularProgressIndicator(),
                      // Text(
                      //   "Country not found or doesn't have any cases",
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w700,
                      //     color: kCriticalColor,
                      //   ),
                      // ),
                    ]),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  //-----------------------------HEADER-----------------------------
                  MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    imageDecoration: true,
                    textTop: "All you need",
                    textBottom: "is stay at home.",
                    offset: offset,
                  ),
                  //-----------------------------SELECT COUNTRY-----------------------------
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        CircularProgressIndicator();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListCountry()));
                      },
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                            Text(
                              (liveCountry.oneResponse == null)
                                  ? 'Select a country'
                                  : liveCountry.oneResponse.data['country'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        //-----------------------------INFO COUNTRY-----------------------------
                        InfoCard(
                            image: liveCountry
                                .oneResponse.data['countryInfo']['flag']
                                .toString(),
                            title: n.format(
                                liveCountry.oneResponse.data['population']),
                            text: liveCountry.oneResponse.data['continent']),
                        SizedBox(height: 10),
                        //-----------------------------CASES UPDATE-----------------------------
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Cases Update\n",
                                    style: kTitleTextstyle,
                                  ),
                                  TextSpan(
                                    text: d
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                liveCountry.oneResponse
                                                    .data['updated']))
                                        .toString()
                                        .split('.')[0],
                                    style: TextStyle(
                                      color: kTextLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        //-----------------------------TOTAL CASES-----------------------------
                        Counter(
                          color: kInfectedColor,
                          number:
                              n.format((liveCountry.oneResponse.data['cases'])),
                          plus: '+' +
                              n.format(
                                  liveCountry.oneResponse.data['todayCases']),
                          title: "Total cases",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------ACTIVES-----------------------------
                        Counter(
                          color: kActiveColor,
                          number:
                              n.format(liveCountry.oneResponse.data['active']),
                          title: "Total active",
                          plus: perc.format(perActivTotal) + '% of total cases',
                        ),
                        SizedBox(height: 10),
                        //-----------------------------CRITICAL-----------------------------
                        Counter(
                          color: kCriticalColor,
                          number: n
                              .format(liveCountry.oneResponse.data['critical']),
                          title: "Critical cases",
                          plus: perc.format(perCritActiv) + '% of total cases',
                        ),
                        SizedBox(height: 20),
                        //-----------------------------RECOVERED-----------------------------
                        Counter(
                          color: kRecovercolor,
                          number: n.format(
                              liveCountry.oneResponse.data['recovered']),
                          title: "Total recovered",
                          plus: '+' +
                              n.format(liveCountry
                                  .oneResponse.data['todayRecovered']),
                        ),
                        SizedBox(height: 10),
                        ChartRadial(
                            sizeHeight: 220.0,
                            sizeWidth: 220.0,
                            number: taxRec,
                            title: 'Recovery rate',
                            color1: kRecovercolor,
                            color2: kShadowColor,
                            plus: ''),
                        SizedBox(height: 10),

                        //-----------------------------DEATHS-----------------------------
                        Counter(
                          color: kDeathColor,
                          number:
                              n.format(liveCountry.oneResponse.data['deaths']),
                          title: "Total deaths",
                          plus: '+' +
                              n.format(
                                  liveCountry.oneResponse.data['todayDeaths']),
                        ),
                        SizedBox(height: 10),
                        ChartRadial(
                            sizeHeight: 220.0,
                            sizeWidth: 220.0,
                            number: taxMort,
                            title: 'Mortality rate',
                            color1: kDeathColor,
                            color2: kShadowColor,
                            plus: ''),
                        SizedBox(height: 10),

                        //-----------------------------TESTS-----------------------------
                        Counter(
                          color: kPrimaryColor,
                          number:
                              n.format(liveCountry.oneResponse.data['tests']),
                          title: "Total tests",
                          plus: '',
                        ),
                        SizedBox(height: 20),
                        //-----------------------------PER MILLION-----------------------------
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Per one million\n",
                                    style: kTitleTextstyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //-----------------------------TOTAL CASES-----------------------------
                        CounterMin(
                          color: kInfectedColor,
                          number: n.format((liveCountry
                              .oneResponse.data['casesPerOneMillion'])),
                          title: "Cases",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------ACTIVES-----------------------------
                        CounterMin(
                          color: kActiveColor,
                          number: n.format((liveCountry
                              .oneResponse.data['activePerOneMillion'])),
                          title: "Active",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------CRITICAL-----------------------------
                        CounterMin(
                          color: kCriticalColor,
                          number: n.format((liveCountry
                              .oneResponse.data['criticalPerOneMillion'])),
                          title: "Critical",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------RECOVERED-----------------------------
                        CounterMin(
                          color: kRecovercolor,
                          number: n.format((liveCountry
                              .oneResponse.data['recoveredPerOneMillion'])),
                          title: "Recovered",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------DEATHS-----------------------------
                        CounterMin(
                          color: kDeathColor,
                          number: n.format((liveCountry
                              .oneResponse.data['deathsPerOneMillion'])),
                          title: "Deaths",
                        ),
                        SizedBox(height: 10),
                        //-----------------------------TESTS-----------------------------
                        CounterMin(
                          color: kPrimaryColor,
                          number: n.format((liveCountry
                              .oneResponse.data['testsPerOneMillion'])),
                          title: "Tests",
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
