import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weight_app/services/api_service/auth_service.dart';
import 'package:flutter_weight_app/services/ui/uiServ.dart';
import '../homepage.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = "LoginPage";
   LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email;
  var password;

   void initState() {
    super.initState();
    autoLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: false,
        ),
        child: SafeArea(
          child: ListView(
            restorationId: 'text_field_demo_list_view',
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  restorationId: 'email_address_text_field',
                  placeholder: "Email",
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'login_password_text_field',
                  placeholder: "Password",
                  clearButtonMode: OverlayVisibilityMode.editing,
                  obscureText: true,
                  autocorrect: false,
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              FlatButton.icon(
                  onPressed: () async {
                    var resp;
                    if (email != null && password != null)
                      resp = await signin(email, password);
                    else
                      resp = {"err": "please provide both email and password"};
                    String token = await checkToken();
                    if (token != "")
                      Navigator.pushNamed(context, HomePage.id);
                    else
                      showAlert(context, "Error", resp["err"], "OK");
                  },
                  icon: Icon(Icons.login),
                  label: Text("Login")),
              FlatButton.icon(
                  onPressed: () async {
                    Navigator.pushNamed(context, SignupPage.id);
                  },
                  icon: Icon(Icons.navigate_before),
                  label: Text("Sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
