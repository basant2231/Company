import 'package:company/features/presentation/views/taskScreendetails.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:company/features/presentation/widgets/Grid&List/taskWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theBloc/taskbloc/bloc/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskBloc _taskBloc; // Declare TaskBloc variable

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc
        .add(FetchTasksEvent()); // Fetch tasks when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskFetchingLoadingState) {
            // Loading state, show a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskFetchSuccessState) {
            // Data loaded successfully, display tasks
            final tasks = state.tasks;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GridView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                       // final task = tasks[index];
                        return TaskWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetails(
                                          authorname: '',
                                          authorposition: '',
                                          category: '',
                                          deadlinedate: '',
                                          taskTitle: '',
                                          taskdescritoon: '',
                                          image: '',
                                        )));
                          },
                          taskTitle: '',
                          taskDescription:'',
                          taskId: '',
                          uploadedBy:'',
                          isDone: true,
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
          } else if (state is TaskFetchFailureState) {
            // Error state, display an error message
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            // Handle other states as needed
            return Container();
          }
        },
      ),
    );
  }
}
