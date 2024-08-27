import 'package:flutter/material.dart';

class appFont {
  // static const double title_fs = 28.43;
  // static const double subtitle_fs = 21.33;
  // static const double body_fs = 16;
  // static const double sub_body_fs = 12;

  static double? _baseUnit;

  static void initialize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _baseUnit = size.width / 100;
  }

  static double _calculateFontSize(double baseSize) {
    return baseSize * (_baseUnit! / 4);
  }

  static double get title_fs => _calculateFontSize(28.43);
  static double get subtitle_fs => _calculateFontSize(21.33);
  static double get body_fs => _calculateFontSize(16);
  static double get sub_body_fs => _calculateFontSize(12);
}
