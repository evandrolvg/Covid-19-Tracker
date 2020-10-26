import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:covid_19/views/nearby/maps_contact.dart';
import 'package:covid_19/helper/constant.dart';

class ContactCard extends StatelessWidget {
  ContactCard({this.imagePath, this.email, this.infected, this.contactUsername, this.contactTime, this.contactLocation});

  final String imagePath;
  final String email;
  final bool infected;
  final String contactUsername;
  final DateTime contactTime;
  final LatLng contactLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: infected ? kInfectedNBColor : kBackgroundColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        trailing: Icon(Icons.more_horiz),
        title: Text(
          email,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          infected ? 'Infected' : 'Not infected',
          style: TextStyle(
            color: infected ? kDeathColor : kPrimaryColor,
          ),
        ),
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                color: Color(0xFF737373), //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(imagePath),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: kTitleTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          infected ? 'INFECTED' : 'NOT INFECTED',
                          style: kTitleTextstyle.copyWith(
                            color: infected ? kDeathColor : kPrimaryColor,
                            fontSize: 13,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'CONTACT TIME',
                          style: kTitleTextstyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          d.format(DateTime.parse(contactTime.toString())).toString().split('.')[0],
                          style: kTitleTextstyle.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GMap(contactLocation: contactLocation)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // textDirection: TextDirection.rtl,
                            // verticalDirection: VerticalDirection.up,
                            children: [
                              SvgPicture.asset("assets/icons/maps-and-flags.svg", height: 30),
                              Text(
                                'See on map',
                                style: TextStyle(color: kPrimaryColor, fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
