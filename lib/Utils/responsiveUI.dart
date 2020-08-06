import 'package:flutter/material.dart';

class ResponsiveWH {
  static double responsiveH(double per, BuildContext context) {
    return MediaQuery.of(context).size.height * per / 100;
  }

  static double responsiveW(double per, BuildContext context) {
    return MediaQuery.of(context).size.width * per / 100;
  }
}
