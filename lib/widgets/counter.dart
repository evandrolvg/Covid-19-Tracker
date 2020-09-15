import 'package:covid_19/constant.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;
  final String plus;
  const Counter({
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
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(.26),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$number",
                style: TextStyle(
                  fontSize: 40,
                  color: color,
                ),
              ),
              Text(plus, style: kSubPlusTextStyle, textAlign: TextAlign.left),
              Text(title, style: kSubTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
