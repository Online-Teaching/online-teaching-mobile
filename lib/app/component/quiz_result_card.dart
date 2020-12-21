import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class AppQuizResultCard extends StatelessWidget {
  final int quizNote;
  final Subject mySubjectList_service;
  final int index;
  final Function onpressed;
  const AppQuizResultCard(
      {Key key,
      this.quizNote,
      this.mySubjectList_service,
      this.index,
      this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.normalValue),
          bottomRight: Radius.circular(context.normalValue),
          topLeft: Radius.circular(context.normalValue),
          topRight: Radius.circular(context.normalValue),
        ),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: context.lowValue * 1.6, vertical: context.lowValue * 0.5),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.normalValue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: new AnimatedCircularChart(
                  size: Size.fromRadius(35),
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          quizNote.toDouble(),
                          Colors.green,
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          100 - quizNote.toDouble(),
                          Colors.blueGrey[200],
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: quizNote.toString(),
                  labelStyle: new TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: context.mediumValue * 0.7,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  mySubjectList_service.title.toUpperCase(),
                  style: context.textTheme.bodyText2.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: context.normalValue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                      width: context.highValue * 0.5,
                      height: context.highValue * 0.5,
                      child: FloatingActionButton(
                        child: Icon(Icons.refresh),
                        backgroundColor: Colors.green,
                        heroTag: mySubjectList_service.id,
                        onPressed: onpressed,
                      ),
                    ),
                    Text(
                      "Tekrar Çöz",
                      style: context.textTheme.bodyText2.copyWith(
                          color: Colors.black,
                          fontSize: context.normalValue * 0.8),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
