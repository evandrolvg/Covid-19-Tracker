import 'package:covid_19/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:covid_19/constant.dart';

class ChartRadial extends StatelessWidget {
  final double sizeHeight;
  final double sizeWidth;
  final double number;
  final String title;
  final String plus;
  final Color color1;
  final Color color2;
  const ChartRadial(
      {Key key,
      this.sizeHeight,
      this.sizeWidth,
      this.number,
      this.title,
      this.plus,
      this.color1,
      this.color2})
      : super(key: key);

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(children: <Widget>[
                  new AnimatedCircularChart(
                    //key: _chartKey,
                    size: Size(sizeHeight, sizeWidth),
                    initialChartData: <CircularStackEntry>[
                      new CircularStackEntry(
                        <CircularSegmentEntry>[
                          new CircularSegmentEntry(
                            number,
                            color1,
                            rankKey: 'completed',
                          ),
                          new CircularSegmentEntry(
                            100 - number,
                            color2,
                            rankKey: 'remaining',
                          ),
                        ],
                        rankKey: 'progress',
                      ),
                    ],
                    chartType: CircularChartType.Radial,
                    percentageValues: true,
                    holeLabel: perc.format(number) + '%',
                    labelStyle: new TextStyle(
                      fontSize: 30,
                      color: color1,
                    ),
                  )
                ]),
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
