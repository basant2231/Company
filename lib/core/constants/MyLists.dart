





import 'package:flutter/cupertino.dart';

import '../../features/presentation/pages/addTaskScreen.dart';
import '../../features/presentation/pages/allWorkersScreen.dart';
import '../../features/presentation/pages/logoutScreen.dart';
import '../../features/presentation/pages/profileScreen.dart';
import '../../features/presentation/pages/taskScreen.dart';

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
    const LogoutScreen(),
  ];

}