import 'package:company/features/presentation/theBloc/bloc/auth_bloc.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/images_manager.dart';
import '../../../core/constants/colors_managers.dart';
import '../../../core/helpingFunctions.dart';
import '../widgets/Buttons/SocialButton.dart';
import '../widgets/Buttons/logOutButton.dart';
import '../widgets/Dialogs/errorsuccessDialog.dart';
import '../widgets/Others/socialInfo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var titleTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  final bool _isLoading = false;
  String phoneNumber = "";
  String email = "";
  String name = "";
  String job = "";
  String? imageUrl;
  String joinedAt = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final AuthBloc authbloc = BlocProvider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const MyDrawer(),
      body: _isLoading
          ? const Center(
              child: Text(
                'Fetching data',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          : SingleChildScrollView(
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
                                '$job Since joined $joinedAt',
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
                                        '5345353543', context);
                                  },
                                ),
                                SocialButton(
                                  color: Colors.red,
                                  icon: Icons.mail_outline_outlined,
                                  onPressed: () {
                                    LaunchUtilsFunctions.mailTo(
                                        '5345353543', context);
                                  },
                                ),
                                SocialButton(
                                  color: Colors.purple,
                                  icon: Icons.call_outlined,
                                  onPressed: () {
                                    LaunchUtilsFunctions.callPhoneNumber(
                                        '5345353543', context);
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
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                      imageUrl == null
                                          ? MyImages.checkmark
                                          : MyImages.clock,
                                    ),
                                    fit: BoxFit.fill)),
                          )
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
