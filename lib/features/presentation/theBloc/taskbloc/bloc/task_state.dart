part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState();
  
  @override
  List<Object> get props => [];
}

 class TaskInitial extends TaskState {}
class TaskAddedSuccessState extends TaskState {
 final  Tasks tasks;
  const TaskAddedSuccessState({
    required this.tasks,
  });
  
}
class TaskAddedLoadingState extends TaskState {}

class TaskAddedFailureState extends TaskState {
  final String error;

  const TaskAddedFailureState({required this.error});
}





class TaskFetchingLoadingState extends TaskState {}

class TaskFetchSuccessState extends TaskState {
  final List<TaskModel> tasks;

  const TaskFetchSuccessState({required this.tasks});
}

class TaskFetchFailureState extends TaskState {
  final String error;

  const TaskFetchFailureState({required this.error});
}


class TaskDeletingLoadingState extends TaskState {}

class TaskDeleteSuccessState extends TaskState {
 
}

class TaskDeleteFailureState extends TaskState {
  final String error;

  const TaskDeleteFailureState({required this.error});

  @override
  List<Object> get props => [error];
}

class TaskUpdateStatusLoadingState extends TaskState {}

class TaskUpdateStatusSuccessState extends TaskState {}

class TaskUpdateStatusFailureState extends TaskState {
  final String error;

  TaskUpdateStatusFailureState({required this.error});

  @override
  List<Object> get props => [error];
}