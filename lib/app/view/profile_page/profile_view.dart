import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/profile_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar.dart';
import 'package:online_teaching_mobile/core/component/appbar_with_stack.dart';
import 'package:online_teaching_mobile/core/component/quiz_result_card.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProfileView extends ProfileViewModel {
  final logger = Logger(printer: SimpleLogPrinter('profile_view.dart'));
  Size size;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");

    size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [appbar(size, context), body()],
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

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        height: size.height * 0.2,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            MyAppBarWithStack(
              text: "Eda Ersu",
              radius: 70,
            ),
            Positioned(
              bottom: -80,
              child: Container(
                  width: 170,
                  height: 170,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/vecteurs-libre/robot-mignon-prendre-selfie-photo-icone-isole-fond-bleu-intelligence-artificielle-technologie-moderne_48369-13410.jpg'),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 5,
      child: Container(
        margin: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 30,
                        height: 30,
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
                                    fontSize: 15, fontWeight: FontWeight.bold));
                          } else {
                            getAverage();
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                )),
            Expanded(
              flex: 10,
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
              )),
            ),
          ],
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
