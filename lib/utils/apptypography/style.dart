import 'package:flutter/material.dart';
import 'package:wegas/utils/color_palette/colors.dart';

abstract class AppTypography{
  static TextStyle mainStyle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.8,
    fontFamily: 'Pricedown'
  );
  static TextStyle robotoStyle = TextStyle(
      color: AppColors.white,
      fontFamily: 'Roboto'
  );
}