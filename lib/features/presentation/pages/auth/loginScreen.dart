import 'package:company/core/constants/images_manager.dart';
import 'package:company/core/validation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';
import '../../../../core/constants/textstyle_manager.dart';
import '../../../../core/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late final TextEditingController _emailTextController =
      TextEditingController(text: '');
  late final TextEditingController _passTextController =
      TextEditingController(text: '');
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();
  final FocusNode _passFocusNode = FocusNode();

  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
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
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                MyImages.login1,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: FractionalOffset(animation.value, 0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: ListView(
              children: [
                Row(
                  children: [
                    const Text(
                      'Welcome\n back to',
                      style: Mytextstyle.headingStyle,
                    ),
                    Expanded(
                        child: Image.asset(MyImages.logo,
                            height: 180, width: 230)),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'Login',
                      style: Mytextstyle.headingStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account?',
                        style:
                            Mytextstyle.inputTextStyle.copyWith(fontSize: 20),
                      ),
                      const TextSpan(text: '   '),
                      TextSpan(
                        text: 'Register',
                        style: Mytextstyle.linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(Routes.registerPagekey);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passFocusNode),
                        validator: (value) {
                          if (value!.isEmpty || !value.isEmailValid()) {
                            return 'Please enter a valid Email address';
                          }
                          return null;
                        },
                        controller: _emailTextController,
                        style: Mytextstyle.inputTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: MyColors.wwhite),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.wwhite),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.llightblue),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.rred),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onEditingComplete: () {
                          _passFocusNode.unfocus();
                        },
                        focusNode: _passFocusNode,
                        validator: (value) {
                          if (value!.isEmpty || !value.isPasswordValid()) {
                            return 'Please enter a valid password (at least 6 characters)';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        controller: _passTextController,
                        style: Mytextstyle.inputTextStyle,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.wwhite,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: Mytextstyle.inputTextStyle,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.wwhite),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.llightblue),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: MyColors.rred),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Routes.forgotpassordPagekey);
                    },
                    child: const Text(
                      'Forget password?',
                      style: Mytextstyle.linkStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      _loginFormKey.currentState!.validate();
                    }
                    Navigator.of(context).pushNamed(Routes.layoutkey);
                  },
                  color: MyColors.llightblue,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide.none,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: MyColors.wwhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.login,
                        color: MyColors.wwhite,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
