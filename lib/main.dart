import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart';
import 'core/route_manager.dart';
import 'features/presentation/theBloc/bloc/auth_bloc.dart';
import 'features/presentation/theBloc/taskbloc/bloc/task_bloc.dart';


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

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'poppins',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.indigo[100],
        ),
        debugShowCheckedModeBanner: false,
        //  home: const TaskScreen(),
        routes: Routes.routes,
       initialRoute: FirebaseAuth.instance.currentUser == null
      ? Routes.registerPagekey
      : Routes.layoutkey,
      ),
    );
  }
}
