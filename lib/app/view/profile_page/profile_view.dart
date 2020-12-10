import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/profile_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar_with_stack.dart';
import 'package:online_teaching_mobile/core/component/quiz_result_card.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/constant/user.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:toast/toast.dart';

class ProfileView extends ProfileViewModel {
  final logger = Logger(printer: SimpleLogPrinter('profile_view.dart'));
  bool exitButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    return Scaffold(
      body: Container(
        child: Column(
          children: [appbar(context), body()],
        ),
      ),
    );
  }

  /// shared
  List<String> quizNote = [];
  List<String> quizid = [];

  SharedPreferences preferences;

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    quizid = preferences.getStringList("quizid");
    quizNote = preferences.getStringList("quizNote");
    logger.i("getLocalData | quizid -> $quizid");
    logger.i("getLocalData | quizNote -> $quizNote");
  }

//// current user
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    getLocalData();
    try {
      if (_googleSignIn != null) {
        _googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount account) {
          setState(() {
            _currentUser = account;
          });
          if (_currentUser != null) {
            //_handleGetContact();

          } else {}
        });
        _googleSignIn.signInSilently();
      } else {}
    } catch (e) {}
  }

  Future<void> _handleSignIn() async {
    setState(() {});

    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() {
    try {
      _googleSignIn.disconnect();
      _googleSignIn = null;
    } catch (e) {}
  }

  Expanded appbar(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4),
            height: context.height * 0.2,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                MyAppBarWithStack(
                  text:
                      _currentUser != null ? _currentUser.displayName : "Hey !",
                  radius: context.highValue,
                ),
                Positioned(
                  right: context.lowValue,
                  top: context.mediumValue,
                  child: SizedBox(
                    width: context.highValue * 0.6,
                    child: Visibility(
                      visible: _currentUser == null ? false : exitButtonVisible,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              exitButtonVisible = false;

                              try {
                                String email = _currentUser.email;
                                Toast.show(
                                    "$email hesabından çıkış yapıldı.", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } catch (e) {}
                              _handleSignOut();
                            });
                          }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -context.highValue,
                  child: Container(
                      width: context.width * 0.4,
                      height: context.width * 0.4,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage: _currentUser != null
                              ? (_currentUser.photoUrl == null
                                  ? AssetImage(
                                      'assets/images/default_photo.png')
                                  : NetworkImage(_currentUser.photoUrl))
                              : AssetImage('assets/images/default_photo.png'))),
                ),
                Positioned(
                  bottom: -(context.highValue + 30),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: context.mediumValue,
                          height: context.mediumValue,
                          child: Image.asset('assets/images/star2.png')),
                      SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(
                          future: getAverage(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(star.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold));
                            } else {
                              getAverage();
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 3,
      child: SizedBox(
        child: Container(
          child: FutureBuilder(
            future: getSubjects(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              logger.i("body | quizid -> $quizid");
              logger.i("body | quizNote -> $quizNote");
              if (snapshot.hasData) {
                if (snapshot.hasData != null) {
                  if (mySubjectList_service.length == 0) {
                    return Center(
                      child: Text("Henüz hiç Quiz çözmedin."),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: quizid.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          try {
                            return testCard(
                                mySubjectList_service[index], index);
                          } catch (e) {
                            logger.e("body | show ListView error");
                          }
                        });
                  }
                } else {
                  logger.i("body | snapshot.hasData null");
                  return Center(
                    child: Text("quiz yok"),
                  );
                }
              } else {
                logger.i("body | snapshot.hasData false");

                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  testCard(Subject mySubjectList_service, int index) {
    return AppQuizResultCard(
      quizNote: int.parse(quizNote[index + 1]),
      mySubjectList_service: mySubjectList_service,
      index: index,
      onpressed: () {
        create_Url(mySubjectList_service.id, context);
        navigation.navigateToPage(path: NavigationConstants.DETAIL_VIEW);
      },
    );
  }

  void create_Url(String id, context) {
    String category_url = "";
    String sub_category_url = "";
    id.runes.forEach((int rune) {
      if (isIntNumber(String.fromCharCode(rune))) {
        sub_category_url += String.fromCharCode(rune);
      } else {
        category_url += String.fromCharCode(rune);
      }
    });
    api_category_url = category_url;
    api_sub_category_index = sub_category_url;
    logger.i("create_url | id konusuna gidiliyor.");
  }
}

isIntNumber(String char) {
  List<String> numberList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  if (numberList.contains(char)) {
    return true;
  } else {
    return false;
  }
}
