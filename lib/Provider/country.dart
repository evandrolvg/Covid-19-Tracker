import 'package:flutter/cupertino.dart';

class SCountry with ChangeNotifier {
  String _id = '';
  String _countryName = '';

  String get countryName => _countryName;
  String get countryId => _id;

  setCountryName(String name) {
    _countryName = name;
  }

  setCountryId(String id) {
    _id = id;
  }
}
