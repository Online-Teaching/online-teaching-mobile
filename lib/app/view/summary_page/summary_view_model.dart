import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/summary_page/summary.dart';
import 'package:online_teaching_mobile/core/init/navigation/INavigationService.dart';

abstract class SummaryViewModel extends State<Summary> with BaseViewModel {}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
