import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view_model/login_view_model.dart';
import 'package:online_teaching_mobile/core/component/round_button.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/constant/user.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';
import 'package:toast/toast.dart';

class LoginView extends LoginViewModel {
  final logger = Logger(printer: SimpleLogPrinter('login_view.dart'));
  bool gecis = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    try {
      if (_googleSignIn != null) {
        _googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount account) {
          setState(() {
            _currentUser = account;
          });
          if (_currentUser != null) {
            //_handleGetContact();

          }
        });
        _googleSignIn.signInSilently();
      }
    } catch (e) {}
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      userdisplayname = _currentUser.displayName;
      userphotourl = _currentUser.photoUrl;
      gecis = true;
    } catch (error) {
      print(error);
    }

    navigation.navigateToPageClear(path: NavigationConstants.BOTTOM_NAVIGATION);
    Toast.show("Giriş Yapıldı", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  Future<void> _handleSignOut() {
    try {
      _googleSignIn.disconnect();
      userdisplayname = "";
      userphotourl = "";
      _googleSignIn = null;
    } catch (e) {}
  }

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
          Container(
            margin: EdgeInsets.only(bottom: context.height * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Öğrenmeye Başla !",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: FlatButton(
                    onPressed: _handleSignIn,
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
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: FlatButton(
                    onPressed: () {
                      navigation.navigateToPage(
                          path: NavigationConstants.BOTTOM_NAVIGATION);
                    },
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.red,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Giriş yapmadan devam et",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
