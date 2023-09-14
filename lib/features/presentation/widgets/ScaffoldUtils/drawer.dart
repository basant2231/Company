import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/presentation/widgets/Dialogs/LogOutAlertDialog.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.cyan),
              child: Column(
                children: [
                  Flexible(child: Image.asset('assets/images/checkmark.jpeg')),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                      child: Text(
                    'Work OS Arabic',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.ddarkindego,
                        fontSize: 22,
                        fontStyle: FontStyle.italic),
                  )),
                ],
              )),
          const Divider(
            thickness: 1,
          ),
          _listTiles(
              label: 'Logout',
              fct: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return LogoutDialog();
                  },
                );
              },
              icon: Icons.logout_outlined),
        ],
      ),
    );
  }

}







Widget _listTiles(
    {required String label, required Function fct, required IconData icon}) {
  return ListTile(
    onTap: () {
      fct();
    },
    leading: Icon(
      icon,
      color: MyColors.blue,
    ),
    title: Text(
      label,
      style: TextStyle(
          color: MyColors.ddarkindego,
          fontSize: 20,
          fontStyle: FontStyle.italic),
    ),
  );
}
