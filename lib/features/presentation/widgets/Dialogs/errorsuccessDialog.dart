import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.scale,
    title: 'Error',
    desc: errorMessage,
    btnCancelOnPress: () {
      
    },

  ).show();
}
void showSuccessDialog(BuildContext context, String message) {
  AwesomeDialog(
    btnOkColor: Colors.green,
  btnCancelColor:Colors.green,
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.scale,
    title: 'Successed',
    desc: message,
    btnCancelOnPress: () {
    },

  ).show();
}
