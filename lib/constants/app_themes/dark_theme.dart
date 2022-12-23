import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart';

class DarkTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkColors.scaffoldColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColors.scaffoldColor,
    ),
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkColors.textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.darkColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkColors.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkColors.textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.darkColors.textColor,
      ),
      labelSmall: TextStyle(
        //16
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.darkColors.textColor,
      ),
    ),
  );
}
