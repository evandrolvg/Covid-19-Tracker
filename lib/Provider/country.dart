import 'package:flutter/cupertino.dart';

class SCountry with ChangeNotifier {
  String _countryName = '';

  String get countryName => _countryName;

  setCountryName(String name) {
    _countryName = name;
  }
}
