import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../../models/TaskModel.dart';
import '../../../../models/tasks.dart';
import '../../../../viewmodel/task_view_model.dart';

part 'task_event.dart';
part 'task_state.dart';
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskViewModel _taskViewModel = TaskViewModel();

  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>(_handleAddTaskEvent);
    on<FetchTasksEvent>(_handleFetchTasksEvent);
    on<DeleteTaskEvent>(_handleDeleteTaskEvent); 
    on<UpdateTaskStatusEvent>(_handleUpdateTaskStatusEvent); 
    
  }

  void _handleAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskAddedLoadingState());
    final result = await _taskViewModel.handleAddTaskEvent(event);

    result.fold(
      (error) {
        emit(TaskAddedFailureState(error: error));
      },
      (tasks) {
        emit(TaskAddedSuccessState(tasks: tasks));
      },
    );
  }

  void _handleFetchTasksEvent(
      FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskFetchingLoadingState());
    try {
      final tasks = await _taskViewModel.fetchTasks();
      emit(TaskFetchSuccessState(tasks: tasks));
    } catch (e) {
      emit(TaskFetchFailureState(error: e.toString()));
    }
  }

  // Separate event handler for DeleteTaskEvent
  
  void _handleDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
   // emit(TaskDeletingLoadingState());

    final result = await _taskViewModel.deleteTask(event.taskId);

    result.fold(
      (error) {
        emit(TaskDeleteFailureState(error: error));
      },
      (_) {
        emit(TaskDeleteSuccessState());
      },
    );
  }

 void _handleUpdateTaskStatusEvent(
      UpdateTaskStatusEvent event, Emitter<TaskState> emit) async {
    emit(TaskUpdateStatusLoadingState());

    final result = await _taskViewModel.updateTaskStatus(event.taskId, event.isDone);

    result.fold(
      (error) {
        emit(TaskUpdateStatusFailureState(error: error));
      },
      (_) {
        emit(TaskUpdateStatusSuccessState());
      },
    );
  }
}