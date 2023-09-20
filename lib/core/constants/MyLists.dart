
import 'package:flutter/cupertino.dart';
import '../../features/presentation/views/addTaskScreen.dart';
import '../../features/presentation/views/allWorkersScreen.dart';
import '../../features/presentation/views/profileScreen.dart';
import '../../features/presentation/views/taskScreen.dart';

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
    const AllWorkersScreen(),
    const AddTaskScreen(),
   
  ];

}