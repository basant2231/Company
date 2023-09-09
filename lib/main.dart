import 'package:flutter/material.dart';

import 'features/presentation/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(fontFamily: 'poppins'),
      title: 'Flutter Demo',
      home: const MyCompany(),
    );
  }
}

class MyCompany extends StatelessWidget {
  const MyCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}