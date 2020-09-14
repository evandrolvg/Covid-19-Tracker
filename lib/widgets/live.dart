import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/list_country.dart';
import 'package:covid_19/Provider/api_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LivePage extends StatelessWidget {
  var n = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 0);
  double smallContainerHeight = 70.0;
  final controller = ScrollController();
  double offset = 0;

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
                    textTop: "Fica em casa",
                    textBottom: "ô merda.",
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
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(18.0),
                      //     side: BorderSide(color: Colors.red)),
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
                                  ? 'Selecione um país'
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 100.0,
                          child: Image.network(liveCountry
                              .oneResponse.data['countryInfo']['flag']
                              .toString())),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                          child: Column(
                        children: <Widget>[
                          Text('Country:' +
                              liveCountry.oneResponse.data['country']),
                          Text('Continent:' +
                              liveCountry.oneResponse.data['continent']),
                          Text('Population: ' +
                              liveCountry.oneResponse.data['population']
                                  .toString())
                        ],
                      ))
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  // TextSpan(
                                  //   text:
                                  //       (liveCountry.oneResponse.data['country'] != null)
                                  //           ? liveCountry.oneResponse.data['country']
                                  //           : '',
                                  //   style: kTitleTextstyle,
                                  // ),
                                  // Text(
                                  //                     'Last Updated: ' +
                                  //                         DateTime.fromMillisecondsSinceEpoch(
                                  //                                 liveCountry.oneResponse.data['updated'])
                                  //                             .toString()
                                  //                             .split('.')[0],
                                  //                     style: TextStyle(
                                  //                         fontWeight: FontWeight.w300,
                                  //                         fontStyle: FontStyle.italic),
                                  //                   ),
                                  TextSpan(
                                    text: "Case Update\n",
                                    style: kTitleTextstyle,
                                  ),
                                  TextSpan(
                                    text: DateTime.fromMillisecondsSinceEpoch(
                                            liveCountry
                                                .oneResponse.data['updated'])
                                        .toString()
                                        .split('.')[0],
                                    style: TextStyle(
                                      color: kTextLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Text(
                              "See details",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Counter(
                                color: kInfectedColor,
                                number: n.format(
                                    (liveCountry.oneResponse.data['cases'])),
                                plus: '+' +
                                    n.format(liveCountry
                                        .oneResponse.data['todayCases']),
                                title: "Total cases",
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Counter(
                                color: kRecovercolor,
                                number: n.format(
                                    liveCountry.oneResponse.data['recovered']),
                                title: "Recovered",
                                plus: '+' +
                                    n.format(liveCountry
                                        .oneResponse.data['todayRecovered']),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kShadowColor,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Counter(
                                color: kDeathColor,
                                number: n.format(
                                    liveCountry.oneResponse.data['deaths']),
                                title: "Deaths",
                                plus: '+' +
                                    n.format(liveCountry
                                        .oneResponse.data['todayDeaths']),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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

  // return SingleChildScrollView(
  //   physics: BouncingScrollPhysics(),
  //   child: Container(
  //       child: liveCountry.oneResponse == null
  //           ? Center(child: Text('Loading data...'))
  //           : Container(
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     margin: EdgeInsets.all(8.0),
  //                     padding: EdgeInsets.all(10.0),
  //                     decoration: BoxDecoration(
  //                         gradient: LinearGradient(colors: [
  //                           Colors.blue,
  //                           Colors.white,
  //                           Colors.purple
  //                         ]),
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(12.0))),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: <Widget>[
  //                         Container(
  //                             width: 100.0,
  //                             child: Image.network(liveCountry
  //                                 .oneResponse.data['countryInfo']['flag']
  //                                 .toString())),
  //                         SizedBox(
  //                           width: 30.0,
  //                         ),
  //                         Container(
  //                             child: Column(
  //                           children: <Widget>[
  //                             Text('Country:' +
  //                                 liveCountry.oneResponse.data['country']),
  //                             Text('Continent:' +
  //                                 liveCountry.oneResponse.data['continent']),
  //                             Text('Population: ' +
  //                                 liveCountry.oneResponse.data['population']
  //                                     .toString())
  //                           ],
  //                         ))
  //                       ],
  //                     ),
  //                   ),
  //                   Text(
  //                     'Last Updated: ' +
  //                         DateTime.fromMillisecondsSinceEpoch(
  //                                 liveCountry.oneResponse.data['updated'])
  //                             .toString()
  //                             .split('.')[0],
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.w300,
  //                         fontStyle: FontStyle.italic),
  //                   ),
  //                   Container(
  //                       alignment: Alignment.topCenter,
  //                       margin: EdgeInsets.all(10.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       width: MediaQuery.of(context).size.width,
  //                       height: smallContainerHeight,
  //                       decoration: BoxDecoration(
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0)),
  //                         color: Colors.blue,
  //                       ),
  //                       child: Column(
  //                         children: <Widget>[
  //                           Text(
  //                             'Today Case',
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 14.0),
  //                           ),
  //                           SizedBox(height: 12.0),
  //                           Text(
  //                             liveCountry.oneResponse.data['todayCases']
  //                                 .toString(),
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 18.0),
  //                           )
  //                         ],
  //                       )),
  //                   Container(
  //                       alignment: Alignment.topCenter,
  //                       margin: EdgeInsets.all(10.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       width: MediaQuery.of(context).size.width,
  //                       height: smallContainerHeight,
  //                       decoration: BoxDecoration(
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0)),
  //                         color: Colors.purple,
  //                       ),
  //                       child: Column(
  //                         children: <Widget>[
  //                           Text(
  //                             'Active Case',
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 14.0),
  //                           ),
  //                           SizedBox(height: 12.0),
  //                           Text(
  //                             liveCountry.oneResponse.data['active']
  //                                 .toString(),
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 18.0),
  //                           )
  //                         ],
  //                       )),
  //                   Container(
  //                       alignment: Alignment.topCenter,
  //                       margin: EdgeInsets.all(10.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       width: MediaQuery.of(context).size.width,
  //                       height: smallContainerHeight,
  //                       decoration: BoxDecoration(
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0)),
  //                         color: Colors.redAccent,
  //                       ),
  //                       child: Column(
  //                         children: <Widget>[
  //                           Text(
  //                             'Today Death',
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 14.0),
  //                           ),
  //                           SizedBox(height: 12.0),
  //                           Text(
  //                             liveCountry.oneResponse.data['todayDeaths']
  //                                 .toString(),
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 18.0),
  //                           )
  //                         ],
  //                       )),
  //                   Container(
  //                       alignment: Alignment.topCenter,
  //                       margin: EdgeInsets.all(10.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       width: MediaQuery.of(context).size.width,
  //                       height: smallContainerHeight,
  //                       decoration: BoxDecoration(
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0)),
  //                         color: Colors.red,
  //                       ),
  //                       child: Column(
  //                         children: <Widget>[
  //                           Text(
  //                             'Total Death',
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 14.0),
  //                           ),
  //                           SizedBox(height: 12.0),
  //                           Text(
  //                             liveCountry.oneResponse.data['deaths']
  //                                 .toString(),
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 18.0),
  //                           )
  //                         ],
  //                       )),
  //                   Container(
  //                       alignment: Alignment.topCenter,
  //                       margin: EdgeInsets.all(10.0),
  //                       padding: EdgeInsets.all(8.0),
  //                       width: MediaQuery.of(context).size.width,
  //                       height: smallContainerHeight,
  //                       decoration: BoxDecoration(
  //                         borderRadius:
  //                             BorderRadius.all(Radius.circular(10.0)),
  //                         color: Colors.green,
  //                       ),
  //                       child: Column(
  //                         children: <Widget>[
  //                           Text(
  //                             'Recovered Case',
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 14.0),
  //                           ),
  //                           SizedBox(height: 12.0),
  //                           Text(
  //                             liveCountry.oneResponse.data['recovered']
  //                                 .toString(),
  //                             style: TextStyle(
  //                                 color: Colors.white, fontSize: 18.0),
  //                           )
  //                         ],
  //                       )),
  //                 ],
  //               ),
  //             )),
  // );

}
