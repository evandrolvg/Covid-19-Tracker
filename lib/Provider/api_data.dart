import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class AllData with ChangeNotifier {
  Response oneResponse, allResponse;

  Dio dio = new Dio();

  retrieveOne(String countryName) async {
    try {
      // String _url = 'https://disease.sh/v2/countries/' + CountryName;
      String _url = 'https://disease.sh/v3/covid-19/countries/' +
          countryName +
          '?strict=true&allowNull=false';
      // print(_url);
      // return false;

      oneResponse = await dio.get(_url);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  retriveAll() async {
    try {
      // String _url = 'https://disease.sh/v2/countries/';
      String _url =
          'https://disease.sh/v3/covid-19/countries?yesterday=true&twoDaysAgo=true&allowNull=false';

      allResponse = await dio.get(_url);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
