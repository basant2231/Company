import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';

import '../../views/LayoutScreen.dart';
import '../Dialogs/filterDialog.dart';

AppBar MyAppbar(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: const Text(
      'Tasks',
      style: TextStyle(color: MyColors.blue),
    ),
    leading: IconButton(
      onPressed: () {
        scaffoldKey.currentState?.openDrawer(); // Open the drawer
      },
      icon: const Icon(
        Icons.menu, // You can use the menu icon to indicate the drawer
        color: MyColors.blue,
      ),
    ),
   
  );
}
