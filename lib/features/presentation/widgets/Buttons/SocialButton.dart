import 'package:flutter/material.dart';

class SocialButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final Function() onPressed;

  SocialButton({
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: widget.color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            widget.icon,
            color: widget.color,
          ),
          onPressed: () {
            widget.onPressed();
          },
        ),
      ),
    );
  }
}
