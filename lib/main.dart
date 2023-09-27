import 'package:company/features/presentation/theBloc/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart';
import 'core/route_manager.dart';
import 'features/presentation/theBloc/bloc/auth_bloc.dart';
import 'features/presentation/theBloc/taskbloc/bloc/task_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async'; // Import the async library

// ... Other imports ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool hasInternet = true;
  final connectivityStreamController = StreamController<ConnectivityResult>();

  @override
  void initState() {
    super.initState();

    // Initialize the stream subscription
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      connectivityStreamController.sink
          .add(result); // Add the result to the stream
    });

    // Listen to changes in the stream and update hasInternet accordingly
    connectivityStreamController.stream.listen((result) {
      setState(() {
        hasInternet = result != ConnectivityResult.none;
      });
    });

    // Check initial internet connectivity
    checkInternetConnectivity().then((result) {
      setState(() {
        hasInternet = result;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the stream subscription and stream controller
    connectivitySubscription.cancel();
    connectivityStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialRoute = !hasInternet
        ? Routes.noInternetScreen
        : FirebaseAuth.instance.currentUser == null
            ? Routes.registerPagekey
            : Routes.layoutkey;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
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
        initialRoute: initialRoute,
        routes: Routes.routes,
      ),
    );
  }

  Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
