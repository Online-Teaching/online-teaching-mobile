import 'package:circle_chart/circle_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/view_model/profile_view_model.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProfileView extends ProfileViewModel {
  Size size;

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    getaverage_setstate() {
      setState(() {});
    }

    hello() {
      print("/// profile pagedeki quiz notlar" + quizNote.toString());
      print("/// profile pagedeki quiz idler" + quizid.toString());
    }

    /////

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
  }

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),

        /// searchin altındaki margin
        // It will cover 20% of our total height
        height: size.height * 0.2,
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    //offset: Offset(0, 1),
                    blurRadius: 20,
                    //  color: Colors.blue.withOpacity(0.23),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              child: Container(
                child: Text(
                  "EDA ERSU",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
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
                    //star png
                    SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/star2.png')),
                    SizedBox(
                      width: 10,
                    ),
                    FutureBuilder(
                      future: getAverage(),
                      builder: getAverage() == null
                          ? (context, snapshot) {
                              return Text('-');
                            }
                          : (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(star.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold));
                              } else {
                                return Text('-');
                              }
                            },
                    ),
                  ],
                )),
            Expanded(
              flex: 10,
              child: Container(
                //color: Colors.amber,
                child: FutureBuilder(
                    future: getSubjects(),
                    builder: getSubjects() == null
                        ? Center(child: CircularProgressIndicator())
                        : (BuildContext context, AsyncSnapshot snapshot) {
                            return ListView.builder(
                                itemCount: mySubjectList_service.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => testCard(
                                    mySubjectList_service.reversed
                                        .toList()[index],
                                    index));
                          }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  testCard(Subject mySubjectList_service, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.blueGrey[100],
      child: Card(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          new AnimatedCircularChart(
            size: Size.fromRadius(35),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                    double.parse(quizNote[index + 1]),
                    Colors.green,
                    rankKey: 'completed',
                  ),
                  new CircularSegmentEntry(
                    100 - double.parse(quizNote[index + 1]),
                    Colors.blueGrey[200],
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.Radial,
            percentageValues: true,
            holeLabel: quizNote[index + 1],
            labelStyle: new TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            mySubjectList_service.title.toUpperCase(),
            style: TextStyle(fontSize: 15),
          ),
        ],
      )),
    );
  }
}
