import 'package:flutter/material.dart';

part 'app_colors_dark.dart';

part 'app_colors_light.dart';

class AppColors {
  static const Color blue = Color(0xFF4e5ae8);
  static const Color orange = Color(0xCFFF8746);
  static const Color pink = Color(0xFFff4667);
  static const Color white = Colors.white;
  static const Color primary = blue;
  static const Color dropDownColor=Color(0x994e5ae8);
  static const Color darkGrey = Color(0xFF121212);
  static const Color darkHeader = Color(0xFF424242);

  static _AppColorsLight get lightColors => _AppColorsLight();

  static _AppColorsDark get darkColors => _AppColorsDark();
}
