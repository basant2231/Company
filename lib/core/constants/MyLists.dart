
import 'package:flutter/cupertino.dart';

import '../../features/view/presentation/addTaskScreen.dart';
import '../../features/view/presentation/allWorkersScreen.dart';
import '../../features/view/presentation/profileScreen.dart';
import '../../features/view/presentation/taskScreen.dart';

class MyLists{
 static List<String> jobcategorylist = [
 'Manager',
    'Team Leader',
    'Designer',
    'Web designer',
    'Full stack developer',
    'Mobile developer',
    'Marketing',
    'Digital marketing',
];
 static List<String> taskcategorylist = [
  'business',
  'programming',
  'information technology',
  'human resources',
  'marketing',
  'design',
  'accounting'
];

static final List<Widget> pages = [
    const TaskScreen(),
    const ProfileScreen(),
     AllWorkersScreen(),
    const AddTaskScreen(),
   
  ];

}