import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart';

class LightTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightColors.scaffoldColor,
    primaryColor: AppColors.lightColors.primary,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.lightColors.primary,
    ),
    brightness: Brightness.light,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        //24
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightColors.textColor,
      ),
      titleLarge: TextStyle(
        //22
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.lightColors.textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightColors.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightColors.textColor,
      ),
      bodyLarge: TextStyle(
        //16
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightColors.textColor,
      ),
      labelSmall: TextStyle(
        //16
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightColors.textColor,
      ),
    ),
  );
}
