import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.title});

  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(title, style: TextStyle(fontSize: 16.sp),),),
      ),
    );
  }
}
