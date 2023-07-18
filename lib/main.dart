import 'package:flutter/material.dart';
import 'package:flutter_spring_boot_app_demo/screen/create_screen.dart';
import 'package:flutter_spring_boot_app_demo/screen/detail_screen.dart';
import 'package:flutter_spring_boot_app_demo/screen/home_screen.dart';

import 'screen/edit_screen.dart';

void main() {
  // print('Hello world');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 28),
              iconTheme: IconThemeData(color: Colors.white)),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30)))),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateScreen.routeName: (context) => const CreateScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
        EditScreen.routeName: (context) => const EditScreen(),
      },
    );
  }
}
