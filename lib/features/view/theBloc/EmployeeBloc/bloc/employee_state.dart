part of 'employee_bloc.dart';

 class EmployeeState extends Equatable {
  const EmployeeState();
  
  @override
  List<Object> get props => [];
}

 class EmployeeInitial extends EmployeeState {}

class EmployeeLoadingState extends EmployeeState {}

class EmployeeLoadedState extends EmployeeState {
  final List<EmployeeModel> employees;

  EmployeeLoadedState({required this.employees});

  @override
  List<Object> get props => [employees];
}

class EmployeeErrorState extends EmployeeState {
  final String error;

  EmployeeErrorState({required this.error});

  @override
  List<Object> get props => [error];
}