import 'package:flutter/material.dart';

Widget mainLogo() {
  return Container(
      padding: EdgeInsets.fromLTRB(10,30,10,10),
      child: Image.asset(
        'images/appicon512.png',
        fit: BoxFit.contain,
      )
  );
}