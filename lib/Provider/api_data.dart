import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class AllData with ChangeNotifier {
  Response oneResponse, allResponse;

  Dio dio = new Dio();

  retrieveOne(String countryName) async {
    // String _url = 'https://disease.sh/v2/countries/' + CountryName;
    String _url = 'https://disease.sh/v3/covid-19/countries/' +
        countryName +
        '?strict=true&allowNull=false';

    oneResponse = await dio.get(_url);
    notifyListeners();
  }

  retriveAll() async {
    // String _url = 'https://disease.sh/v2/countries/';
    String _url =
        'https://disease.sh/v3/covid-19/countries?yesterday=true&twoDaysAgo=true&allowNull=false';

    allResponse = await dio.get(_url);
    notifyListeners();
  }

  // 3cddb57701f3475c8f4b2fb855f2cadd
}
