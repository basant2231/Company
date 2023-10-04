import 'package:company/features/presentation/widgets/Grid&List/allWorkerswidget.dart';
import 'package:company/features/presentation/widgets/ScaffoldUtils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theBloc/EmployeeBloc/bloc/employee_bloc.dart';

class AllWorkersScreen extends StatefulWidget {
  const AllWorkersScreen({Key? key}) : super(key: key);

  @override
  State<AllWorkersScreen> createState() => _AllWorkersScreenState();
}

class _AllWorkersScreenState extends State<AllWorkersScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc()..add(FetchEmployeesEvent()), // Provide the EmployeeBloc here
      child: Scaffold(
        drawer: const MyDrawer(),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoadedState) {
              final employees = state.employees;
              
              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  final employee = employees[index];
                  return AllWorkersWidget(
                    employeeName: employee.fullName,
                    employeeEmail: employee.email,
                    positionInCompany: employee.position,
                    phoneNumber: employee.phoneNumber,
                    employeeImageUrl: employee.imagePath,
                  );
                },
              );
            } else if (state is EmployeeErrorState) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity
                      .BOTTOM, // Also possible: ToastGravity.TOP, ToastGravity.CENTER
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return Center(
                child: Text(state.error),
              );
            }
          
            return const Center(
              child: Text('Unknown state'),
            );
          },
        ),
      ),
    );
  }
}
