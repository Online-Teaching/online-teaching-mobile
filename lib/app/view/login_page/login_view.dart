import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view_model/login_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';

class LoginView extends LoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            navigation.navigateToPageClear(
              path: NavigationConstants.BOTTOM_NAVIGATION,
            );
          },
        ),
      ),
    );
  }
}
