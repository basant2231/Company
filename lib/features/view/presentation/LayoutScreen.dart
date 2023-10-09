import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:company/core/constants/MyLists.dart';
import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/view/widgets/ScaffoldUtils/MyAppbar.dart';

import 'package:flutter/material.dart';

import '../widgets/ScaffoldUtils/drawer.dart';


class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _LayoutState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTabController(
          length: MyLists.pages.length,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const MyDrawer(),
            body: Container(
              color: Colors.indigo[100],
              child: Column(
                children: <Widget>[
                  MyAppbar(context),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ButtonsTabBar(
                      contentPadding: const EdgeInsets.all(10),
                      backgroundColor: Colors.indigo[500],
                      unselectedBackgroundColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: MyColors.ddarkindego,
                        fontWeight: FontWeight.bold,
                      ),
                      height: 55,
                      borderWidth: 2,
                      unselectedBorderColor: MyColors.ddarkindego,
                      radius: 100,
                      tabs: const [
                        Tab(
                          text: "All tasks",
                        ),
                        Tab(
                          text: "My Account",
                        ),
                        Tab(
                          text: "Registered Workers",
                        ),
                        Tab(
                          text: "Add task",
                        ),
                      
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: MyLists.pages,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
