import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_midjouney/features/ui/create_prompt_screen.dart';

import 'features/bloc/prompt_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromptBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Midjourney',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade900,
              elevation: 0
          ),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900,
          useMaterial3: true,
        ),
        home: CreatePromptScreen(),
      ),
    );
  }
}

