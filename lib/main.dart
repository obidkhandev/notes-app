import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes_app/utils/route_name.dart';

import 'data/local/local_database.dart';

void main() {

  runApp(
      MultiBlocProvider(providers: [
          BlocProvider(create: (_)=> NotesBloc(),
          ),
  ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteName.home,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}

