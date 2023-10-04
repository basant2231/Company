import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/EmployeeModel.dart';
import '../../../../viewmodel/Employee_view_model.dart';

part 'employee_event.dart';
part 'employee_state.dart';

final EmployeeViewModel _employeeViewModel = EmployeeViewModel();
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<FetchEmployeesEvent>(_handleFetchEmployeeEvent);
  }
}

void _handleFetchEmployeeEvent(
  FetchEmployeesEvent event,
  Emitter<EmployeeState> emit,
) async {
  emit(EmployeeLoadingState());

  final eitherEmployee = await _employeeViewModel.fetchTasks();
  
    eitherEmployee.fold(
      (error) => emit(EmployeeErrorState(error: error)), // Emit error state
      (theEmployee) => emit(EmployeeLoadedState(employees: theEmployee)), // Emit loaded state
    );
    
 
}
