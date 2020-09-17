import 'package:covid_19/constant.dart';
// import 'package:covid_19/widgets/counter.dart';
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final String number;
  final Color color;
  final String title;
  final String plus;
  const Card({
    Key key,
    this.number,
    this.color,
    this.title,
    this.plus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        // children: <Widget>[
        //   Counter(
        //     color: kInfectedColor,
        //     number: n.format((liveCountry.oneResponse.data['cases'])),
        //     plus: '+' + n.format(liveCountry.oneResponse.data['todayCases']),
        //     title: "Total cases",
        //   )
        // ],
      ),
    );
  }
}
