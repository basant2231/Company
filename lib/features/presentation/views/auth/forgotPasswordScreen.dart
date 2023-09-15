

import 'package:company/core/constants/colors_managers.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/images_manager.dart';
import '../../../../core/constants/textstyle_manager.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State< ForgetPasswordScreen> createState() => ForgetPasswordScreenState();
}


class ForgetPasswordScreenState extends State< ForgetPasswordScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
 late final TextEditingController _forgetPasswordController =
      TextEditingController(text: '');


  @override
  void dispose() {
    _animationController.dispose();
      _forgetPasswordController.dispose();
  
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 17));
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.red,
        body: Stack(
      children: [
        Image.asset(
            MyImages.login1,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            alignment: FractionalOffset(animation.value, 0),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Text(
                'Forget password',
                style: Mytextstyle.headingStyle
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Email adress',
              style:Mytextstyle.normalStyle
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  controller: _forgetPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.llightblue),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: (){},
                color: MyColors.llightblue,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide.none),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Reset now',
                        style:Mytextstyle.normalStyle
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}