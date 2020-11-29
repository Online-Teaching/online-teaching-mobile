import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/home_page/home.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class HomeViewModel extends State<Home> with BaseViewModel {}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
