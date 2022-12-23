import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/ui/widgets/conditional_builder.dart';

import '../../../../constants/app_themes/app_colors/app_colors.dart';

class NoContentPlaceholder extends StatefulWidget {
  const NoContentPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  State<NoContentPlaceholder> createState() => _NoContentPlaceholderState();
}

class _NoContentPlaceholderState extends State<NoContentPlaceholder> {
  bool condition = false;

  @override
  initState() {
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 500),
        () => setState(() {
              condition = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      successWidget: (ctx) => Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/images/task.svg',
              height: 100.h,
              color: AppColors.blue,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "You Don't have any Tasks Yet \n Add New One",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
        ],
      ),
      condition: condition,
      fallbackWidget: (BuildContext context) {
        return Column(
          children: [
            SizedBox(height: 50.h,),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
