import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  void Function() ontap;
   LogoutButton({
    super.key,required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: MaterialButton(
          onPressed: ontap,
          color: Colors.pink.shade700,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
              side: BorderSide.none),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
