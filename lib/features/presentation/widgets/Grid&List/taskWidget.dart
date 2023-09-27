import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/images_manager.dart';
import '../../../../core/route_manager.dart';

class TaskWidget extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String uploadedBy;
  final bool isDone;
  void Function()? onTap;
  
  TaskWidget({
    Key? key,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskId,
    required this.uploadedBy,
    required this.isDone,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Card(
          elevation: 30,
          color: getRandomBlueColor(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        isDone ? MyImages.checkmark : MyImages.clock,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Column(
                    children: [
                      Text(
                        taskTitle,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[400]!),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        taskDescription,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        uploadedBy,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color getRandomBlueColor() {
  final List<Color> blueShades = [
    Colors.indigo[300]!,
    Colors.indigo[400]!,
    Colors.indigo[500]!,
    Colors.indigo[600]!,
    Colors.indigo[700]!,
    Colors.indigo[800]!,
    Colors.indigo[900]!,
  ];

  final Random random = Random();
  return blueShades[random.nextInt(blueShades.length)];
}
