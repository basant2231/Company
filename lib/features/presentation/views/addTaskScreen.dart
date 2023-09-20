import 'package:company/core/constants/colors_managers.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/MyLists.dart';
import '../../models/taskmodel.dart';
import '../theBloc/taskbloc/bloc/task_bloc.dart';
import '../widgets/Dialogs/errorsuccessDialog.dart';
import '../widgets/Others/addtaskFormField.dart';
import '../widgets/Dialogs/categoryDialog.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _categoryController =
      TextEditingController(text: 'choose a category');
  final TextEditingController _titleController =
      TextEditingController(text: '');

  final TextEditingController _descriptionController =
      TextEditingController(text: '');
  final TextEditingController _deadlineDateController =
      TextEditingController(text: 'pick up a date');
  final _formKey = GlobalKey<FormState>();
  DateTime? picked;

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskAddedSuccessState) {
          showSuccessDialog(context, 'Task Added');
        } else if (state is TaskAddedFailureState) {
          showErrorDialog(context, state.error);
        } else if (state is TaskAddedLoadingState) {
          const CircularProgressIndicator();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textsWidget(textLabel: 'Task category*'),
                            textFormFields(
                                valueKey: 'TaskCategory',
                                controller: _categoryController,
                                enabled: false,
                                fct: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CategoryDialog(
                                        categoryList: MyLists.taskcategorylist,
                                        onCategorySelected: (selectedCategory) {
                                          _categoryController.text =
                                              selectedCategory;
                                        },
                                        size: size, // Pass the 'size' parameter
                                      );
                                    },
                                  );
                                },
                                maxLength: 100),
                            textsWidget(textLabel: 'Task title*'),
                            textFormFields(
                                valueKey: 'Tasktitle',
                                controller: _titleController,
                                enabled: true,
                                fct: () {},
                                maxLength: 100),
                            textsWidget(textLabel: 'Task Description*'),
                            textFormFields(
                                valueKey: 'TaskDescription',
                                controller: _descriptionController,
                                enabled: true,
                                fct: () {},
                                maxLength: 1000),
                            textsWidget(textLabel: 'Task Deadline date*'),
                            textFormFields(
                                valueKey: 'DeadlineDate',
                                controller: _deadlineDateController,
                                enabled: false,
                                fct: () {
                                  _pickDate();
                                },
                                maxLength: 100),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: MaterialButton(
                                  onPressed: () {
                                    // Validate the form
                                    if (_formKey.currentState!.validate()) {
                                      // Create an instance of Tasks with the form data
                                      final tasks = Tasks(
                                        personId: currentUser?.displayName ??
                                            '', // Replace with the actual person ID
                                        taskCategory: _categoryController.text,
                                        taskTitle: _titleController.text,
                                        taskDescription:
                                            _descriptionController.text,
                                        taskDeadlineDate:
                                            _deadlineDateController.text,
                                      );

                                      // Dispatch the AddTaskEvent with the Tasks data
                                      taskBloc.add(AddTaskEvent(tasks: tasks));
                                      clearTextFields();
                                    }
                                  },
                                  color: MyColors.ddarkindego,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: BorderSide.none),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 14),
                                        child: Text(
                                          'Upload',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.indigo, // Set the primary color to indigo
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _deadlineDateController.text =
            '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  void clearTextFields() {
    _categoryController.clear();
    _titleController.clear();
    _descriptionController.text = '';
    _deadlineDateController.text = '';
    _deadlineDateController.text = 'pick up a date';

    _categoryController.text = 'choose a category';
  }
}

textsWidget({String? textLabel}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      textLabel!,
      style: const TextStyle(
          fontSize: 18, color: MyColors.blue, fontWeight: FontWeight.bold),
    ),
  );
}
