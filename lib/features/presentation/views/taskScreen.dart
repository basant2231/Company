import 'package:company/features/presentation/views/taskScreendetails.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:company/features/presentation/widgets/Grid&List/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theBloc/taskbloc/bloc/task_bloc.dart';
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskBloc _taskBloc;
  GlobalKey<FormState> _homeKey = GlobalKey<FormState>(debugLabel: '_homeScreenkey');

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(FetchTasksEvent());
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
        listener: (context, state) {},
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskFetchingLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TaskFetchSuccessState) {
              final tasks = state.tasks;
              final uniqueKey = ObjectKey(tasks);

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
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.69,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is TaskFetchFailureState) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              _refreshData();
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
