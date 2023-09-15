import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/MyAppbar.dart';
import 'package:company/features/presentation/widgets/Grid&List/allWorkerswidget.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:flutter/material.dart';

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: const MyDrawer(),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const AllWorkersWidget(
                userID: 'dadas',
                userName: 'dfsfs',
                userEmail: 'fadfsa',
                positionInCompany: 'dafagvs',
                phoneNumber: 'fsa',
                userImageUrl: 'adasfs',
              );
            }));
  }
}
