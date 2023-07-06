import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/presentation/screens/auth_screens/login_screen.dart';

import 'presentation/blocs/auth_screen/auth_screen_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:
      BlocProvider(
          create: (context) => AuthScreenBloc(),
          child: const LoginScreen()),

      // const LoginScreen(),
      // BlocProvider(
      //   create: (context) => JournalScreenBloc(),
      //     child: const JournalScreen(title: 'Flutter Demo Home Page')
      // ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}