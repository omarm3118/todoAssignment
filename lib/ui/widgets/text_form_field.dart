import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/strings.dart';

class DefaultTextFormField extends StatelessWidget {
  final String hint;
  final TextStyle hintStyle;
  final Widget title;
  final Widget? preIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool isReadOnly;

  const DefaultTextFormField({
    Key? key,
    required this.hint,
    this.preIcon,
    this.isReadOnly = false,
    this.suffixIcon,
    this.keyboardType,
    this.textEditingController,
    this.validator,
    this.textInputAction,
    required this.title,
    required this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        Container(
          height: 60.h,
          margin: EdgeInsetsDirectional.only(top: 5.r),
          child: TextFormField(
            maxLines: 1,

            validator: validator,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            controller: textEditingController,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hintStyle,
              prefixIcon: preIcon,
              suffixIcon: suffixIcon,

              //contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius),
              ),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
              )),
              focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
