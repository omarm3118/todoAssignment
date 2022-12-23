import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart';
import 'package:todo/constants/strings.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final TextStyle? labelStyle;

  const DefaultButton(
      {Key? key, required this.label, required this.onPressed, this.labelStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          child: Text(label,
              style: labelStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      )),
        ),
      ),
    );
  }
}
