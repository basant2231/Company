import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';

class LogoutDialog extends StatefulWidget {

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.logout_sharp,
              size: 20,
            ),
          ),
          Text('Sign out'),
        ],
      ),
      content: Text(
        'Do you want to Sign out?',
        style: TextStyle(
          color: MyColors.ddarkindego, // Make sure MyColors is defined
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: const Text(
            'Close',
            style: TextStyle(color: MyColors.rred), // Change MyColors.rred to your desired color
          ),
        ),
        TextButton(
          onPressed: () {
          
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
