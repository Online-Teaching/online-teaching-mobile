import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/profile_page/profile.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class ProfileViewModel extends State<Profile> with BaseViewModel {}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
