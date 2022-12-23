import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  bool condition;
  final Widget Function(BuildContext context) successWidget;
  final Widget Function(BuildContext context) fallbackWidget;

  ConditionalBuilder({
    Key? key,
    required this.successWidget,
    required this.fallbackWidget,
    required this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return successWidget(context);
    } else {
      return fallbackWidget(context);
    }
  }
}
