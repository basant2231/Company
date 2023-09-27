part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState();
  
  @override
  List<Object> get props => [];
}

 class TaskInitial extends TaskState {}
class TaskAddedSuccessState extends TaskState {
 final  Tasks tasks;
  TaskAddedSuccessState({
    required this.tasks,
  });
  
}
class TaskAddedLoadingState extends TaskState {}

class TaskAddedFailureState extends TaskState {
  final String error;

  TaskAddedFailureState({required this.error});
}





class TaskFetchingLoadingState extends TaskState {}

class TaskFetchSuccessState extends TaskState {
  final List<Tasks> tasks;

  TaskFetchSuccessState({required this.tasks});
}

class TaskFetchFailureState extends TaskState {
  final String error;

  TaskFetchFailureState({required this.error});
}