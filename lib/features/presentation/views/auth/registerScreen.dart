import 'dart:io';

import 'package:company/core/validation.dart';
import 'package:company/features/presentation/widgets/Dialogs/jobDialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/colors_managers.dart';
import '../../../../core/constants/images_manager.dart';
import '../../../../core/constants/textstyle_manager.dart';
import '../../../../core/route_manager.dart';
import '../../../models/Registermodel.dart';
import '../../theBloc/bloc/auth_bloc.dart';
import '../../widgets/Dialogs/ImageDialog.dart';
import '../../widgets/Dialogs/errorsuccessDialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  late final TextEditingController _fullnameTextController =
      TextEditingController(text: '');
  late final TextEditingController _emailTextController =
      TextEditingController(text: '');
  late final TextEditingController _passTextController =
      TextEditingController(text: '');
  late final TextEditingController _positionCPTextController =
      TextEditingController(text: '');
  late final TextEditingController _phoneTextController =
      TextEditingController(text: '');
  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _positionFocusNode = FocusNode();
  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showImage = false;
  File? imageFile;
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
  void dispose() {
    _animationController.dispose();
    _fullnameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _positionCPTextController.dispose();
    _fullnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionFocusNode.dispose();
    _phoneFocusNode.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ImagePickedSuccessState) {
          showImage = true;
          imageFile = state.imageFile;
        } else if (state is ImagePickedFailedState) {
          showErrorDialog(context, state.errorMessage);
        }else

        if (state is RegistrationLoadingState) {
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: registerBody(context, size, showImage, imageFile),
          );
        } else if (state is RegistrationFailureState) {
          showErrorDialog(context, state.errorMessage);
        } else if(state is RegistrationSuccessState){
          showSuccessDialog(context,
              'Registration Successful!\nYou are now a registered user.');

          Future.delayed(const Duration(seconds: 4), () {
            Navigator.pushReplacementNamed(context, Routes.layoutkey);
          });
        }
      },
      child: registerBody(context, size, showImage, imageFile),
    );
  }

  Scaffold registerBody(
      BuildContext context, Size size, bool showImage, File? imageFile) {
    return Scaffold(
      key: _scaffoldKey,
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
                Row(
                  children: [
                    const Text('Auth', style: Mytextstyle.headingStyle),
                    FittedBox(
                        child: Image.asset(MyImages.logo,
                            height: 150, width: 150)),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Already have an account?  ',
                          style: Mytextstyle.inputTextStyle),
                      TextSpan(
                        text: 'Login',
                        style: Mytextstyle.linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .pushNamed(Routes.loginPageKey);
                          },
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              focusNode: _fullnameFocusNode,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field can\'t be missing';
                                }
                                return null;
                              },
                              controller: _fullnameTextController,
                              style: Mytextstyle.inputTextStyle,
                              decoration: const InputDecoration(
                                hintText: 'Full name',
                                hintStyle: Mytextstyle.inputTextStyle,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.wwhite),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.llightblue),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyColors.rred),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.24,
                                    height: size.width * 0.24,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: MyColors.wwhite),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: showImage
                                            ? Image.file(
                                                imageFile!,
                                                fit: BoxFit.cover,
                                                height: 90,
                                                width: 90,
                                              )
                                            : const Icon(
                                                Icons.person,
                                                color: MyColors.wwhite,
                                                size: 90,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const ImageDialogWidget();
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.llightblue,
                                        border: Border.all(
                                            width: 2, color: MyColors.wwhite),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 18,
                                          color: MyColors.wwhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
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
                          hintStyle: Mytextstyle.inputTextStyle,
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
                        focusNode: _passFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneFocusNode),
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        focusNode: _phoneFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(_positionFocusNode);
                          _phoneFocusNode.unfocus();
                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.isMobileNumberValid()) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          print(
                              '_phoneTextController.text ${_phoneTextController.text}');
                        },
                        controller: _phoneTextController,
                        style: Mytextstyle.inputTextStyle,
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: Mytextstyle.inputTextStyle,
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
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return JobsDialog(
                                context: context,
                                size: size,
                                positionController: _positionCPTextController,
                              );
                            },
                          );
                        },
                        child: TextFormField(
                          enabled: false,
                          focusNode: _positionFocusNode,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            // _positionCPTextController.text = MyLists.jobcategorylist[index];
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field can\'t be missing';
                            }
                            return null;
                          },
                          controller: _positionCPTextController,
                          style: Mytextstyle.inputTextStyle,
                          decoration: const InputDecoration(
                            hintText: 'Position in the company',
                            hintStyle: Mytextstyle.inputTextStyle,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.wwhite),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.wwhite),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: MyColors.llightblue),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.rred),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  onPressed: () {
                      if (imageFile != null) {
                    if (_signUpFormKey.currentState!.validate()) {
                        final registrationModel = RegistrationModel(
                          fullName: _fullnameTextController.text,
                          emailAddress: _emailTextController.text,
                          password: _passTextController.text,
                          phoneNumber: _phoneTextController.text,
                          position: _positionCPTextController.text,
                          imageFile: imageFile!,
                        );

                        BlocProvider.of<AuthBloc>(context).add(
                          RegisterUserEvent(
                            registrationModel: registrationModel,
                          ),
                        );
                       
                      } else {
                        showErrorDialog(context, 'Pass the Images');
                      }
                    }
                  },
                  color: MyColors.llightblue,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: BorderSide.none,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text('Auth',
                            style: Mytextstyle.headingStyle
                                .copyWith(fontSize: 20)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.person_add,
                        color: MyColors.wwhite,
                      )
                    ],
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