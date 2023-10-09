
import 'package:flutter/material.dart';

import '../features/view/presentation/LayoutScreen.dart';
import '../features/view/presentation/addTaskScreen.dart';
import '../features/view/presentation/allWorkersScreen.dart';
import '../features/view/presentation/auth/forgotPasswordScreen.dart';
import '../features/view/presentation/auth/loginScreen.dart';
import '../features/view/presentation/auth/registerScreen.dart';
import '../features/view/presentation/eachWorker.dart';
import '../features/view/presentation/noInternet.dart';
import '../features/view/presentation/profileScreen.dart';
import '../features/view/presentation/splashٍScreen.dart';
import '../features/view/presentation/taskScreen.dart';
import '../features/view/presentation/taskScreendetails.dart';


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
