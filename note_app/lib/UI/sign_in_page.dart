import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/UI/home_page.dart';
import 'widgets/common/snackBar.dart';
import '../cubit/auth/auth_cubit.dart';
import '../routers/page_const.dart';
import 'widgets/button.dart';
import 'widgets/text_field.dart';
import '../cubit/credentials/credential_cubit.dart';
import '../models/user_model.dart';

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

  Widget _bodyWidget() {
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
            CustomButton(title: "Log in", onTap: _submitSignIn),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text("Don\'t have an account"),
                SizedBox(width: 5.w),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.signUp, (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, credentialState) {
        if (credentialState is CredentialSuccess) {
          context.read<AuthCubit>().loggedIn(credentialState.user.uid!);
        }
        if (credentialState is CredentialFailure) {
          showSnackBarMessage(credentialState.errorMsg, context);
        }
      }, builder: (context, credentialState) {
        if (credentialState is CredentialLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (credentialState is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            },
          );
        }
        return _bodyWidget();
      }),
    );
  }

  void _submitSignIn() {
    if (_emailcontroller.text.isEmpty) {
      showSnackBarMessage("Enter Email", context);
      return;
    }
    if (_pwdcontroller.text.isEmpty) {
      showSnackBarMessage("Enter Password", context);
      return;
    }
    context.read<CredentialCubit>().signin(
        UserModel(email: _emailcontroller.text, password: _pwdcontroller.text));
  }
}
