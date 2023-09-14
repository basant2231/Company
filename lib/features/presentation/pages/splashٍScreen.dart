import 'dart:async';

import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/images_manager.dart';
import '../../../core/route_manager.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  Timer? timer;
  bool imageLoaded = false; // Track whether the image is loaded

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 2500), _goNext);
    _loadImage(); // Load the image when the widget initializes
  }

  void _loadImage() async {
    // Simulate loading the image with a delay (replace with actual loading logic)
    await Future.delayed(const Duration(milliseconds: 1));

    // Mark the image as loaded
    setState(() {
      imageLoaded = true;
    });
  }

  void _goNext() {
    Navigator.pushReplacementNamed(context, Routes.loginPageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue,
      body: Center(
        child: Container(
          width: 420,
          height: 420,
          decoration: const BoxDecoration(
            // Use the background color as a placeholder
            color: MyColors.blue,
          ),
          child: imageLoaded
              ? TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 1), // Animation duration
                  tween: Tween<double>(begin: 0, end: 1), // Opacity animation
                  builder: (BuildContext context, double value, Widget? child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    MyImages.logo,
                    fit: BoxFit.cover,
                  ),
                )
              : const CircularProgressIndicator(), // Show a loading indicator
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
