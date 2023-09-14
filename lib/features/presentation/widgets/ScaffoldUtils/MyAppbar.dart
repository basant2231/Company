import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';

import '../../pages/LayoutScreen.dart';
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
    actions: [
      IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FilterDialog(context: context, size: size);
            },
          );
        },
        icon: const Icon(
          Icons.filter_list_outlined,
          color: MyColors.blue,
        ),
      ),
    ],
  );
}
