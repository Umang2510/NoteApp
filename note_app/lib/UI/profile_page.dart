import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/UI/widgets/common/snackBar.dart';
import '../cubit/user/user_cubit.dart';
import '../models/user_model.dart';

import 'widgets/button.dart';
import 'widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final String? uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    context.read<UserCubit>().myProfile(UserModel(uid: widget.uid));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroller.dispose();
    _pwdcontroller.dispose();
    super.dispose();
  }

  void _updateProfile() {
    if ((_usercontroller.text.isEmpty) && (_pwdcontroller.text.isEmpty)) {
      showSnackBarMessage("Enter Username and Password", context);
      return;
    }
    context
        .read<UserCubit>()
        .updateProfile(UserModel(
          uid: widget.uid,
          username: _usercontroller.text,
          password: _pwdcontroller.text,
        ))
        .then((_) =>
            showSnackBarMessage("Profile updated successfully.", context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              _updateDetails(userState.user);
              return Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextField(
                        hint: "User name", controller: _usercontroller),
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
                    CustomButton(
                        title: "Update Profile", onTap: _updateProfile),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _updateDetails(UserModel user) {
    _emailcontroller.value = TextEditingValue(text: user.email!);
    _usercontroller.value = TextEditingValue(text: user.username!);
  }
}
