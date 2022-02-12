import 'package:flutter/material.dart';
import 'package:flutter_weight_app/pages/auth/loginpage.dart';
import 'pages/auth/signup_page.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignupPage(title: 'sign up'), routes: {
      SignupPage.id: (context) => SignupPage(title: 'sign up'),
      LoginPage.id: (context) => LoginPage(title: 'Log in'),
      HomePage.id: (context) => const HomePage(title: 'Weight app'),
    }
    );
  }
}
