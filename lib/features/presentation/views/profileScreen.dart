import 'package:company/features/presentation/theBloc/bloc/auth_bloc.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/colors_managers.dart';
import '../../../core/helpingFunctions.dart';
import '../theBloc/bloc/profile_bloc.dart';
import '../widgets/Buttons/SocialButton.dart';
import '../widgets/Buttons/logOutButton.dart';
import '../widgets/Dialogs/errorsuccessDialog.dart';
import '../widgets/Others/socialInfo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    ProfileBloc().add(FetchProfileEvent());
    super.initState();
  }
  var titleTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  String phoneNumber = "";
  String email = "";
  String name = "";
  String job = "";
  String imageUrl = ""; // Initialize imageUrl to an empty string
  String joinedAt = "";
  String position = "";

  @override
  Widget build(BuildContext context) {
    final AuthBloc authbloc = BlocProvider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Scaffold(
            drawer: MyDrawer(),
            body: Center(
              child: CircularProgressIndicator()
            ),
          );
        } else if (state is ProfileSuccessState) {
          final registrationModel = state.profile;

          name = registrationModel.fullName;
          job = registrationModel.position;
          email = registrationModel.emailAddress;
          phoneNumber = registrationModel.phoneNumber;
          position = registrationModel.position;
          imageUrl = registrationModel.imagePath as String; // Assign imageUrl or an empty string if null

          return Scaffold(
            drawer: const MyDrawer(),
            body: SingleChildScrollView(
              child: Center(
                child: Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                name,
                                style: titleTextStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                job,
                                style: TextStyle(
                                  color: MyColors.ddarkindego,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Contact Info',
                              style: titleTextStyle,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SocialInfo(
                              label: 'Email:',
                              content: email,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SocialInfo(
                              label: 'Phone number:',
                              content: phoneNumber,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SocialButton(
                                  color: Colors.green,
                                  icon: FontAwesomeIcons.whatsapp,
                                  onPressed: () {
                                    LaunchUtilsFunctions.openWhatsAppChat(
                                      phoneNumber,
                                      context,
                                    );
                                  },
                                ),
                                SocialButton(
                                  color: Colors.red,
                                  icon: Icons.mail_outline_outlined,
                                  onPressed: () {
                                    LaunchUtilsFunctions.mailTo(email, context);
                                  },
                                ),
                                SocialButton(
                                  color: Colors.purple,
                                  icon: Icons.call_outlined,
                                  onPressed: () {
                                    LaunchUtilsFunctions.callPhoneNumber(
                                      phoneNumber,
                                      context,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return LogoutButton(ontap: () {
                                  showLogoutDialog(context, () {
                                    authbloc.add(LogOutEvent());
                                  });
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.26,
                            height: size.width * 0.26,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 5,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: 
                                     NetworkImage(imageUrl)
                                  ,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ProfileErrorState) {
          return Scaffold(
            drawer: const MyDrawer(),
            body: Center(
              child: Text('Error: ${state.errorMessage}'),
            ),
          );
        } else {
          return const Scaffold(
            drawer: MyDrawer(),
            body: Center(
              child: Text('Unknown state'),
            ),
          );
        }
      },
    );
  }
}
