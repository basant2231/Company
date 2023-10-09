import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/images_manager.dart';

class TaskWidget extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String uploadedBy;
  final String category;
  final bool isDone;
  void Function()? onTap;

  TaskWidget({
    Key? key,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskId,
    required this.uploadedBy,
    required this.category,
    required this.isDone,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetImage imageAsset = isDone
        ? const AssetImage(MyImages.checkmark)
        : const AssetImage(MyImages.clock);

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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:
                                Image(image: imageAsset, fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskTitle,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                    'category : $category',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    'uploaded by : $uploadedBy',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
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
    Colors.indigoAccent.shade400,
    Colors.indigoAccent.shade700,
    Colors.indigoAccent.shade200,
    Colors.indigo[300]!,
    Colors.indigo[400]!,
    Colors.indigo[500]!,
    Colors.indigo[600]!,
    Colors.indigo[700]!,
    Colors.indigo[800]!,
    Colors.indigo[900]!,
    Colors.indigoAccent.shade400,
    Colors.indigoAccent.shade700,
    Colors.indigoAccent.shade200,
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
