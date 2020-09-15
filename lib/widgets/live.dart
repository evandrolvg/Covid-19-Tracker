import 'package:covid_19/widgets/my_header.dart';
//import 'package:covid_19/widgets/info_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/list_country.dart';
import 'package:covid_19/Provider/api_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  var n = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 0);
  final d = new DateFormat('dd MMMM, hh:mm a');
  double smallContainerHeight = 70.0;
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
    final liveCountry = Provider.of<allData>(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: liveCountry.oneResponse == null
            ? Center(child: Text('Loading data...'))
            : Column(
                children: <Widget>[
                  MyHeader(
                    image: "assets/icons/Drcorona.svg",
                    textTop: "All you need",
                    textBottom: "is stay at home.",
                    offset: offset,
                  ),
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
                        //INFO COUNTRY
                        InfoCard(
                            image: liveCountry
                                .oneResponse.data['countryInfo']['flag']
                                .toString(),
                            title: n.format(
                                liveCountry.oneResponse.data['population']),
                            text: liveCountry.oneResponse.data['continent']),
                        SizedBox(height: 10),
                        //CASES UPDATE
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
                        //TOTAL CASES
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
                        //ACTIVES
                        Counter(
                            color: kActiveColor,
                            number: n
                                .format(liveCountry.oneResponse.data['active']),
                            title: "Total active",
                            plus: ''),
                        SizedBox(height: 10),
                        //RECOVERED
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
                        //DEATHS
                        Counter(
                          color: kDeathColor,
                          number:
                              n.format(liveCountry.oneResponse.data['deaths']),
                          title: "Total deaths",
                          plus: '+' +
                              n.format(
                                  liveCountry.oneResponse.data['todayDeaths']),
                        ),
                        SizedBox(height: 20),
                        //MAPS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Spread of Virus",
                              style: kTitleTextstyle,
                            ),
                            Text(
                              "See details",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(20),
                          height: 178,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 30,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/map.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const InfoCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Image.network(
                image,
                width: 120,
              ),
            ),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'POPULATION',
                      style: kTitleTextstyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'CONTINENT',
                      style: kTitleTextstyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
