import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart';
import 'core/route_manager.dart';
import 'features/presentation/Bloc/register_bloc/register_bloc.dart';

void main() {
   Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
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
        initialRoute: Routes.registerPagekey,
         
      ),
    );
  }
}
