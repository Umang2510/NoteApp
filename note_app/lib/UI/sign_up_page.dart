import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routers/page_const.dart';
import 'widgets/button.dart';
import 'widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();

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
          title: const Text("Sign Up"),
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
            CustomTextField(hint: "User name", controller: _usercontroller),
            SizedBox(height: 15.h),
            CustomTextField(hint: "Email", controller: _emailcontroller),
            SizedBox(height: 10.h),
            CustomTextField(
              hint: "Password",
              controller: _pwdcontroller,
              obscure: true,
            ),
            SizedBox(height: 15.h),
            const CustomButton(title: "Sign Up"),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text("Already have an account"),
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        PageConst.signIn, (route) => false);
                  },
                  child: Text(
                    "Sign in",
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
