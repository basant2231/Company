
import 'package:company/features/view/presentation/taskScreendetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theBloc/profileBloc/profile_bloc.dart';
import '../theBloc/taskbloc/bloc/task_bloc.dart';
import '../widgets/Dialogs/errorsuccessDialog.dart';
import '../widgets/Grid&List/taskWidget.dart';
import '../widgets/ScaffoldUtils/drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
String? commentername;
String? commenterurl;

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskBloc _taskBloc;
  final GlobalKey<FormState> _homeKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  void _updateTaskStatus(String taskId, bool isDone) {
    // Dispatch an event to update the task status using Bloc or another method.
    _taskBloc.add(UpdateTaskStatusEvent(taskId: taskId, isDone: isDone));
  }

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    // _taskBloc.add(FetchTasksEvent());
  }

  void _refreshData() {
    _taskBloc.add(FetchTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeKey,
      drawer: const MyDrawer(),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskDeleteFailureState) {
            _refreshData();
            showFailureDialog(context, state.error);
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskFetchingLoadingState) {
              _refreshData();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TaskFetchSuccessState) {
              final tasks = state.tasks;
              final uniqueKey = ObjectKey(tasks);

              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileSuccessState) {
                    final registrationModel = state.profile;
                    var name = registrationModel.fullName;
                    var imageUrl = registrationModel.imagePath ?? '';
                    commentername = name;
                    commenterurl = imageUrl;
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GridView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskDetails(
                                        key: uniqueKey,
                                        authorname: task.authorName,
                                        authorposition: task.authorPosition,
                                        category: task.taskCategory,
                                        deadlinedate: task.taskDeadlineDate,
                                        taskTitle: task.taskTitle,
                                        taskdescritoon: task.taskDescription,
                                        imagee: task.taskImage,
                                        beginningdate: task.taskBeginningDate,
                                        taskId: task.taskId,
                                      ),
                                    ),
                                   
                                  );
                           
                                },
                                taskTitle: task.taskTitle,
                                taskDescription: task.taskDescription,
                                taskId: task.taskId,
                                uploadedBy: task.authorName,
                                isDone: task.isDone,
                                category: task.taskCategory,
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.69,
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              _refreshData();
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
