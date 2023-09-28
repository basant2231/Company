import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';


class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.7,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/4.png',
                            height: screenWidth * 0.65,
                            width: screenWidth * 0.65,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
                      child: Text(
                        "No Connection",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.ddarkindego,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.w600,
                          height: 1.33,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: screenWidth * 0.85,
                      child: Text(
                        'So, it looks like you do not have an internet connection right now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[800]!,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
