import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class serverException implements Exception {
  final String errorMsg;
  serverException({required this.errorMsg});
}

class NetworkRepository {
  final http.Client httpClient = http.Client();

  String _endPoint(String endPoint) {
    return "http://localhost:5000/v1/${endPoint}";
  }

  Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8",
  };

  Future<UserModel> signUp(UserModel user) async {
    final encodedParam = json.encode(user.toJson());
    final response = await httpClient.post(Uri.parse(_endPoint("user/signup")),
        body: encodedParam, headers: _header);
    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJSON(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

  Future<UserModel> signIn(UserModel user) async {
    final encodedParam = json.encode(user.toJson());
    final response = await httpClient.post(Uri.parse(_endPoint("user/signin")),
        body: encodedParam, headers: _header);
    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJSON(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }
}