import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_themes/app_colors/app_colors.dart';
import '../../../constants/strings.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.title, required this.body})
      : super(key: key);
  static const String route = 'notificationRoute';
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${title}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kPadding.r),
        child: Column(
          children: [
            SizedBox(height: 50.h,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(kRadius),
                ),
                child: Text(
                  body,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
