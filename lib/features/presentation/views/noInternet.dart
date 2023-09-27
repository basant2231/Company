import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({
    Key? key,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388,
      height: 551,
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
                  width: 350,
                  height: 350,
                  // Adjusted padding to reduce space
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0, // Adjusted horizontal padding
                    vertical: 10, // Adjusted vertical padding
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/sad.png',
                      ),
                    ],
                  ),
                ),
                // Adjusted SizedBox height
                SizedBox(
                  width: 343,
                  child: Text(
                    "No Connection",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: MyColors.ddarkindego,
                      fontSize: 24,
                   
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Adjusted SizedBox height
                const SizedBox(
                  width: 343,
                  child: Text(
                    'so, it looks like you do not have an internet connection right now',
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                  
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
