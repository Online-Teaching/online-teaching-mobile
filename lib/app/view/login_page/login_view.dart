import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view_model/login_view_model.dart';
import 'package:online_teaching_mobile/app/component/round_button.dart';
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
                    image: AssetImage('assets/images/back3.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: context.height * 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Giriş Yap",
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
                  child: RaisedButton(
                    onPressed: _handleSignIn,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.red[600],
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/logo/google.png'),
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Google ile giriş",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
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
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.red[600],
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Giriş yapmadan devam et",
                      style: TextStyle(
                          color: Colors.grey[700],
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
