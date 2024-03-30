import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/cubit/user/user_cubit.dart';
import '/UI/sign_in_page.dart';
import '/UI/home_page.dart';
import '/cubit/auth/auth_cubit.dart';
import '/cubit/credentials/credential_cubit.dart';
import 'routers/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => AuthCubit()..appStarted()),
            BlocProvider<CredentialCubit>(create: (_) => CredentialCubit()),
            BlocProvider<UserCubit>(create: (_) => UserCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NoteApp',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: child,
            onGenerateRoute: OnGenerateRoute.route,
            routes: {
              "/": (context) {
                return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, authState) {
                  if (authState is Authenticated) {
                    if (authState.uid == "") {
                      return SignIn();
                    } else {
                      return HomePage(uid: authState.uid);
                    }
                  } else {
                    return SignIn();
                  }
                });
              },
            },
          ),
        );
      },
    );
  }
}
