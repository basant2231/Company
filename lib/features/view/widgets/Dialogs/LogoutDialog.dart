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
          color: MyColors.ddarkindego,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: MyColors.rred),
          ),
        ),
        TextButton(
          onPressed: () {
            // Perform your logout logic here
            // For example, you can call a function to log the user out
            // authService.logout();
            
            // Close the dialog
            Navigator.of(context).pop();
            
            // Call setState to trigger a rebuild of the widget that needs to reflect the logged-out state
            setState(() {
              // Update your state variables here
              // For example, set isLoggedIn = false
            });
          },
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}

