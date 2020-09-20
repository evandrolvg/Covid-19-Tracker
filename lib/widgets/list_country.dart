import 'package:covid_19/Provider/api_data.dart';
import 'package:covid_19/Provider/country.dart';
import 'package:covid_19/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final country = Provider.of<SCountry>(context);
    final liveCountry = Provider.of<AllData>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:
              Text('Pick your Country', style: TextStyle(color: Colors.blue)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 500,
              child: CountryListView(
                showDialCode: false,
                scrollPhysics: BouncingScrollPhysics(),
                onSelected: (Country countryName) async {
                  liveCountry.retrieveOne(countryName.code);
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('country', countryName.code);
                  country.setCountryName(countryName.code);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
