


import 'package:flutter/material.dart';

import 'colors_managers.dart';

class Mytextstyle{
  static const TextStyle headingStyle = TextStyle(
    fontSize: 30,
    color: MyColors.wwhite,
    fontWeight: FontWeight.bold,
  );
 

  static const TextStyle linkStyle = TextStyle(
    color: MyColors.llightblue,
    decoration: TextDecoration.underline,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle normalStyle = TextStyle(
    color: MyColors.wwhite,

    fontSize: 19,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: MyColors.wwhite,
  );
}