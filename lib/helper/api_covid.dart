// import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class AllData with ChangeNotifier {
  Response oneResponse, allResponse;

  Dio dio = new Dio();

  retrieveOne(String countryName) async {
    // oneResponse.data = [];
    try {
      if (countryName != null) {
        // String _url = 'https://disease.sh/v2/countries/' + CountryName;
        String _url = 'https://disease.sh/v3/covid-19/countries/' +
            countryName +
            '?strict=true&allowNull=false';
        oneResponse = await dio.get(_url);
        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        // oneResponse.data['country'] = json.encode('Not found');
        oneResponse.data['code'] = e.response.statusCode;
        print(e.response.statusCode);
      } else {
        // oneResponse.data['country'] = json.encode('Not found');
        oneResponse.data['code'] = e.response.statusCode;
        print(e.message);
        print(e.request);
      }
    }
  }

  retriveAll() async {
    // allResponse.data = [];
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
