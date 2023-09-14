
import 'package:company/features/presentation/pages/LayoutScreen.dart';
import 'package:company/features/presentation/pages/auth/forgotPasswordScreen.dart';
import 'package:flutter/material.dart';

import '../features/presentation/pages/addTaskScreen.dart';
import '../features/presentation/pages/allWorkersScreen.dart';

import '../features/presentation/pages/auth/loginScreen.dart';
import '../features/presentation/pages/auth/registerScreen.dart';
import '../features/presentation/pages/profileScreen.dart';
import '../features/presentation/pages/splashٍScreen.dart';
import '../features/presentation/pages/taskScreen.dart';
import '../features/presentation/pages/taskScreendetails.dart';

class Routes {

  static const String loginPageKey = '/Login';
  static const String registerPagekey = '/Register';
  static const String forgotpassordPagekey = '/Forgotpassord';
  static const String splashkey = '/splash';
  static const String addTaskScreenkey = '/addTaskScreenkey';
  static const String allWorkersScreenkey = '/allWorkersScreenkey';
  static const String profileScreenkey = '/profileScreenkey';
  static const String taskScreenkey = '/taskScreenkey';
  static const String layoutkey = '/layoutkey';
  static const String taskDetailskey = '/taskDetailskey';

  static Map<String, WidgetBuilder> get routes {
    return {

       loginPageKey: (context) => const LoginScreen(),
      registerPagekey: (context) => const RegisterScreen(),
      forgotpassordPagekey: (context) => const ForgetPasswordScreen(),
      splashkey: (context) => const SplashScreen(),
      addTaskScreenkey: (context) => const AddTaskScreen(),
      allWorkersScreenkey: (context) => const AllWorkersScreen(),
      profileScreenkey: (context) => const ProfileScreen(),
      taskScreenkey: (context) => const TaskScreen(),
      layoutkey: (context) => const LayoutScreen(),
      taskDetailskey: (context) =>  TaskDetails(),
     
    };
  }
}
