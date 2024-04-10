import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/note_model.dart';
import '../models/user_model.dart';

class serverException implements Exception {
  final String errorMsg;
  serverException({required this.errorMsg});
}

class NetworkRepository {
  final http.Client httpClient = http.Client();

  String _endPoint(String endPoint) {
    return "http://10.0.2.2:8000/v1/${endPoint}";
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

  Future<UserModel> myProfile(UserModel user) async {
    final response = await httpClient.get(
        Uri.parse(_endPoint("user/myprofile?uid=${user.uid}")),
        headers: _header);
    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJSON(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final encodedParam = json.encode(user.toJson());
    final response = await httpClient.put(
        Uri.parse(_endPoint("user/updateprofile")),
        body: encodedParam,
        headers: _header);
    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJSON(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

  Future<List<NoteModel>> getMyNotes(NoteModel note) async {
    final response = await httpClient.get(
        Uri.parse(_endPoint("note/getmynotes?uid=${note.creatorId}")),
        headers: _header);
    if (response.statusCode == 200) {
      List<dynamic> notes = json.decode(response.body)['response'];
      final notesData = notes.map((item) => NoteModel.fromJson(item)).toList();

      return notesData;
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

  Future<void> addNote(NoteModel note) async {
    final encodedParam = json.encode(note.toJson());
    final response = await httpClient.post(Uri.parse(_endPoint("note/addnote")),
        body: encodedParam, headers: _header);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

    Future<void> updateNote(NoteModel note) async {
    final encodedParam = json.encode(note.toJson());
    final response = await httpClient.put(Uri.parse(_endPoint("note/updatenote")),
        body: encodedParam, headers: _header);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    final encodedParam = json.encode(note.toJson());
    final response = await httpClient.delete(
        Uri.parse(_endPoint("note/deletenote")),
        body: encodedParam,
        headers: _header);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw serverException(errorMsg: json.decode(response.body)['response']);
    }
  }
}
