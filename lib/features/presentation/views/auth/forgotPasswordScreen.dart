import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/images_manager.dart';
import '../../theBloc/bloc/auth_bloc.dart';
import '../../widgets/Dialogs/errorsuccessDialog.dart';

bool isDialogShown = false;
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
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

  void _handleResetPassword() {
    if (_forgetPasswordController.text.isNotEmpty) {
      final email = _forgetPasswordController.text;
      final event = ForgotPasswordEvent(email: email);

      BlocProvider.of<AuthBloc>(context).add(event);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
    final authBloc = BlocProvider.of<AuthBloc>(context);

    Size size = MediaQuery.of(context).size;
    return forgetpassScreen(size);
  }

  Scaffold forgetpassScreen(Size size) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            MyImages.login1,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Forget password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email address',
                  style: TextStyle(fontSize: 18),
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
                        borderSide: BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordLoadingState) {
                     const CircularProgressIndicator();
                    } else if (state is ForgotPasswordSuccessState) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showSuccessDialog(
                            context, 'Password reset email sent successfully');
                      });
                    } else if (state is ForgotPasswordFailureState) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showSuccessDialog(
                            context, 'Password reset failed: ${state.error}');
                      });
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      _handleResetPassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide.none,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Reset now',
                        style: TextStyle(fontSize: 18),
                      ),
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
