import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var n = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 0);
var perc = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
final d = new DateFormat('dd MMMM, hh:mm a');
// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kActiveColor = Color(0xFFFF4848);
const kDeathColor = Color(0xFFE60C0C);
const kCriticalColor = Color(0xFF872712);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kSubMTextStyle = TextStyle(fontSize: 16, color: kBackgroundColor);

const kSubPlusTextStyle =
    TextStyle(fontSize: 13, color: kBodyTextColor, letterSpacing: 2);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);
