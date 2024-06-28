
import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/colors.dart';

class MyTextStyle{
  static const title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: MyColors.title,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: MyColors.subtitle,
  );

  static const titleInputs = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: MyColors.primary,
    letterSpacing: -0.5,
  );
}