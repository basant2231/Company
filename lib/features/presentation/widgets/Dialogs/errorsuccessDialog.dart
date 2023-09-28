import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../core/route_manager.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: 'Error',
    desc: errorMessage,
    btnCancelOnPress: () {},
  ).show();
}

void showSuccessDialog(BuildContext context, String message) {
  AwesomeDialog(
    btnOkColor: Colors.green,
    btnCancelColor: Colors.green,
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: 'Successed',
    desc: message,
    btnCancelOnPress: () {},
  ).show();
}

void showLogoutDialog(
    BuildContext context, Function onConfirmLogout) {
  AwesomeDialog(
    btnOkColor: Colors.blue,
    btnCancelColor: Colors.red,
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: 'Confirm Logout',
    desc: 'Are you sure you want to logout?',
    btnCancelOnPress: () {
    },
    btnOkOnPress: () {
      onConfirmLogout();
      Navigator.pushReplacementNamed(context, Routes.loginPageKey);
    },
  ).show();
    }
void showDeleteDialog(
    BuildContext context, Function onConfirm) {
  AwesomeDialog(
    btnOkColor: Colors.blue,
    btnCancelColor: Colors.red,
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: 'Confirm Deleting Task',
    desc: 'Are you sure you want to Delet this Task?',
    btnCancelOnPress: () {
    },
    btnOkOnPress: () {
     onConfirm();
     
    },
  ).show();
}

void showFailureDialog(BuildContext context, String error) {
    AwesomeDialog(
      btnOkColor: Colors.blue,
      btnCancelColor: Colors.red,
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      title: 'Error Deleting the Task',
      desc: error,
      btnCancelOnPress: () {},
      
    ).show();
  }