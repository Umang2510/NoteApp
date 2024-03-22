import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routers/page_const.dart';
import 'widgets/button.dart';
import 'widgets/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroller.dispose();
    _pwdcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign in"),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(children: [
            Center(
              child: Text(
                "Note App",
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
            SizedBox(height: 15.h),
            CustomTextField(hint: "Email", controller: _emailcontroller),
            SizedBox(height: 10.h),
            CustomTextField(
                hint: "Password", controller: _pwdcontroller, obscure: true),
            SizedBox(height: 15.h),
            const CustomButton(title: "Log in"),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text("Don\'t have an account"),
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        PageConst.signUp, (route) => false);
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
