import 'package:company/features/presentation/theBloc/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart';
import 'core/route_manager.dart';
import 'features/models/Registermodel.dart';
import 'features/presentation/theBloc/bloc/auth_bloc.dart';
import 'features/presentation/theBloc/taskbloc/bloc/task_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

// Import the async library
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

RegistrationModel? registrationModel;

class _MyAppState extends State<MyApp> {
  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _profileBloc.add(FetchProfileEvent());
  }

  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        // Check for connectivity and navigate to noInternetScreen if there's no internet
        if (snapshot.data == ConnectivityResult.none) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'poppins',
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.indigo[100],
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.noInternetScreen,
            routes: Routes.routes,
          );
        } else {
          // If there's internet, proceed with the regular MaterialApp
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(),
              ),
              BlocProvider<TaskBloc>(
                create: (context) => TaskBloc()..add(FetchTasksEvent()),
              ),
              BlocProvider(
                create: (context) => ProfileBloc()..add(FetchProfileEvent()),
              )
            ],
            child: MaterialApp(
              theme: ThemeData(
                fontFamily: 'poppins',
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.indigo[100],
              ),
              debugShowCheckedModeBanner: false,
              //  home: const TaskScreen(),
              initialRoute: FirebaseAuth.instance.currentUser == null
                  ? Routes.registerPagekey
                  : Routes.layoutkey,
              routes: Routes.routes,
            ),
          );
        }
      },
    );
  }
}
