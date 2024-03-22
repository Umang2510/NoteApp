import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? obscure;
  const CustomTextField(
      {super.key, required this.hint, this.controller, this.obscure = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(color: Colors.black.withOpacity(.1)),
      child: TextField(
        controller: controller,
        obscureText: obscure!,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
