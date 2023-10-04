
import 'package:company/features/presentation/views/LayoutScreen.dart';
import 'package:company/features/presentation/views/auth/forgotPasswordScreen.dart';
import 'package:flutter/material.dart';

import '../features/presentation/views/addTaskScreen.dart';
import '../features/presentation/views/allWorkersScreen.dart';

import '../features/presentation/views/auth/loginScreen.dart';
import '../features/presentation/views/auth/registerScreen.dart';
import '../features/presentation/views/eachWorker.dart';
import '../features/presentation/views/noInternet.dart';
import '../features/presentation/views/profileScreen.dart';
import '../features/presentation/views/splashٍScreen.dart';
import '../features/presentation/views/taskScreen.dart';
import '../features/presentation/views/taskScreendetails.dart';

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
  static const String noInternetScreen = '/noInternetScreen';
  static const String eachWorkerScreen = '/eachWorkerScreen';

  static Map<String, WidgetBuilder> get routes {
    return {

       loginPageKey: (context) => const LoginScreen(),
      registerPagekey: (context) => const RegisterScreen(),
      forgotpassordPagekey: (context) => const ForgetPasswordScreen(),
      splashkey: (context) => const SplashScreen(),
      addTaskScreenkey: (context) => const AddTaskScreen(),
      allWorkersScreenkey: (context) =>  AllWorkersScreen(),
      profileScreenkey: (context) => const ProfileScreen(),
      taskScreenkey: (context) => const TaskScreen(),
      layoutkey: (context) => const LayoutScreen(),
      taskDetailskey: (context) =>   TaskDetails(),
      noInternetScreen: (context) =>  const NoInternetScreen(),
      eachWorkerScreen: (context) =>  EachWorkerScreen(),
     
    };
  }
}
