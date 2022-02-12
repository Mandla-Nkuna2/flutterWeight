import 'package:flutter_weight_app/pages/auth/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../pages/homepage.dart';

const iosUrl = "http://localhost:5000";
const andUrl = "http://10.0.2.2:8081";
const bUrl = "http://localhost:8081";

checkToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  return token;
}

autoLogin(context) async {
  var token = await checkToken();
  if (token != '') Navigator.pushNamed(context, HomePage.id);
}

saveToken(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', value);
}

signup(email, password) async {
  final response = await http.post(
    Uri.parse(andUrl + '/sign_up'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  var parseObj = jsonDecode(response.body);
  if (parseObj.containsKey("token"))
    await saveToken(parseObj["token"]);
  else
    return parseObj;
}

signin(email, password) async {
  final response = await http.post(
    Uri.parse(andUrl + '/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  var parseObj = jsonDecode(response.body);
  if (parseObj.containsKey("token"))
    await saveToken(parseObj["token"]);
  else
    return parseObj;
}

signOut(context) {
  saveToken("");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignupPage(title: 'sign up')),
  );
}
