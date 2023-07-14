import 'package:flutter/material.dart';

//edf2f4 red  ef233c white
const kYellow = Color(0xffaffc41);
const kMoove = Color(0xff3c1642);
const kCyan = Color(0xff1dd3b0);
const kBlack = Color(0xff086375);
const kCardShadow = BoxShadow(
  //Gives the background of the card a shadow effect.
  color: kBlack,
  blurRadius: 5.0,
  spreadRadius: 2.0,
);
const kBoxShadow = BoxShadow(
  color: Colors.black26,
  spreadRadius: -10.0,
  blurRadius: 10.0,
  offset: Offset(0.0, 10.0),
);
const kBoxShadow2 = BoxShadow(
  color: kYellow,
  spreadRadius: -10.0,
  blurRadius: 10.0,
  offset: Offset(0.0, 10.0),
);

const kBoxShadow3 = BoxShadow(
  color: kBlack,
  spreadRadius: -10.0,
  blurRadius: 10.0,
  offset: Offset(0.0, 10.0),
);

const kModalSheetDecoration = BoxDecoration(
  color: kMoove,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);

const kRoundedRectangle = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);

const kInputTextStyle = TextStyle(
  color: kYellow,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kMessageBoxTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'big_noodle_titling',
  color: kMoove,
);

const kPrefKey = 'fitBox';
const kFavouritesPrefKey = 'Favourites';
