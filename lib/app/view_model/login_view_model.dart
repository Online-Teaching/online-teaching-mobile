import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/login_page/login.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class LoginViewModel extends State<Login> with BaseViewModel {}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
