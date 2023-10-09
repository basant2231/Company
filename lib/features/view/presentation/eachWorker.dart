import 'package:flutter/material.dart';

import '../../../core/constants/textstyle_manager.dart';
import '../../../core/helpingFunctions.dart';
import '../widgets/Buttons/SocialButton.dart';
import '../widgets/Others/socialInfo.dart';
import '../widgets/ScaffoldUtils/drawer.dart';

class EachWorkerScreen extends StatelessWidget {
String? name;
String? employeimage;
String? position;
String? number;
String? email;
   EachWorkerScreen({
    Key? key,
    this.name,
    this.employeimage,
     this.position,
    this.number,
    this.email
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(8.0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back',
                          style: Mytextstyle.detailsTextStyle1
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Stack(
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
                          const SizedBox(height: 80),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              name!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                         Align(
                            alignment: Alignment.center,
                            child: Text(
                              position!,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Divider(thickness: 1),
                          const SizedBox(height: 15),
                          const Text(
                            'Contact Info',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SocialInfo(
                              label: 'Email:', content: email!),
                          const SizedBox(height: 10),
                          SocialInfo(
                              label: 'Phone number:', content: number.toString()),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialButton(
                                color: Colors.green,
                                icon: Icons.message,
                                onPressed: () {
                                  LaunchUtilsFunctions.openWhatsAppChat(number!, context);
                                },
                              ),
                              SocialButton(
                                color: Colors.red,
                                icon: Icons.mail_outline,
                                onPressed: () {
                                LaunchUtilsFunctions.mailTo(email!, context);
                                },
                              ),
                              SocialButton(
                                color: Colors.purple,
                                icon: Icons.call,
                                onPressed: () {
                                  LaunchUtilsFunctions.callPhoneNumber(number!, context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(thickness: 1),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  employeimage!), // Use your default image asset here
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
