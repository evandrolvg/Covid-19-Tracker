// import 'dart:convert';
import 'package:covid_19/helper/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class AllData with ChangeNotifier {
  Response oneResponse, allResponse;

  Dio dio = new Dio();

  retrieveOne(String countryName) async {
    try {
      if (countryName != null) {
        // String _url = 'https://disease.sh/v2/countries/' + CountryName;
        String _url = 'https://disease.sh/v3/covid-19/countries/' + countryName + '?strict=true&allowNull=false';
        oneResponse = await dio.get(_url);
        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response.statusCode == null) {
        oneResponse.data['code'] = null;

        showToast('Not found');
      } else {
        showToast('Not found');
      }
    }
  }

  retriveAll() async {
    try {
      // String _url = 'https://disease.sh/v2/countries/';
      String _url = 'https://disease.sh/v3/covid-19/countries?yesterday=true&twoDaysAgo=true&allowNull=false';

      allResponse = await dio.get(_url);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
