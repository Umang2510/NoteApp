import 'package:flutter/material.dart';

import '/UI/update_note_page.dart';
import '/UI/add_note_page.dart';
import 'page_const.dart';
import '/UI/sign_in_page.dart';
import '/UI/sign_up_page.dart';
import '/UI/profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConst.signUp:
        {
          return materialPageBuilder(widget: SignUp());
        }
      case PageConst.signIn:
        {
          return materialPageBuilder(widget: SignIn());
        }
      case PageConst.profilePpage:
        {
          if (args is String) {
            return materialPageBuilder(
                widget: ProfilePage(
              uid: args,
            ));
          } else {
            return materialPageBuilder(widget: ErroePage());
          }
        }
      case PageConst.addNote:
        {
          if(args is String)
            return materialPageBuilder(widget: AddNotePage(uid: args));
          else  
            return materialPageBuilder(widget: ErroePage());
        }
      case PageConst.updateNote:
        {
          return materialPageBuilder(widget: UpdateNotePage());
        }
      default:
        return materialPageBuilder(widget: ErroePage());
    }
  }
}

class ErroePage extends StatelessWidget {
  const ErroePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: Center(
        child: Text("Error"),
      ),
    );
  }
}

MaterialPageRoute materialPageBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
