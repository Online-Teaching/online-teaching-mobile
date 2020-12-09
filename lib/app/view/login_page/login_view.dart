import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view_model/login_view_model.dart';
import 'package:online_teaching_mobile/core/component/round_button.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

class LoginView extends LoginViewModel {
  final logger = Logger(printer: SimpleLogPrinter('login_view.dart'));
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/resim.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.transparent,
              Color(0xff161d27).withOpacity(0.9),
              Color(0xff161d27),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      filled: true,
                      fillColor: Color(0xff161d27).withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      filled: true,
                      fillColor: Color(0xff161d27).withOpacity(0.5),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: AppButton(
                    text: "Giriş Yap",
                    onpressed: () {
                      navigation.navigateToPage(
                          path: NavigationConstants.BOTTOM_NAVIGATION);
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Google ile giriş",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Kayıl Ol",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
