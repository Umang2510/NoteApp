import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void setUid(String uid) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("currentUserId", uid);
  }

  Future<String?> getUid() async {
    final pref = await SharedPreferences.getInstance();
    pref.getString("currentUserId");
  }
}
