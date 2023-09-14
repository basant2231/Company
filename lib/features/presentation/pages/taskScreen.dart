import 'package:company/core/constants/colors_managers.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/MyAppbar.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:company/features/presentation/widgets/Grid&List/taskWidget.dart';
import 'package:flutter/material.dart';



class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    return const TaskWidget(
                      taskTitle: "Title",
                      taskDescription: 'Description',
                      taskId: 'Da',
                      uploadedBy: 'Adsa',
                      isDone: true,
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.69,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5)),
            ),
          ),
        ],
      ),
    );
  }

}

