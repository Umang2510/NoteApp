import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/button.dart';
import 'widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  void _updateProfile() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(hint: "User name", controller: _usercontroller),
              SizedBox(height: 15.h),
              AbsorbPointer(
                  child: CustomTextField(
                      hint: "Email", controller: _emailcontroller)),
              SizedBox(height: 10.h),
              CustomTextField(
                hint: "Password",
                controller: _pwdcontroller,
                obscure: true,
              ),
              SizedBox(height: 15.h),
              CustomButton(title: "Update Profile", onTap: _updateProfile),
            ],
          ),
        ),
      ),
    );
  }
}
