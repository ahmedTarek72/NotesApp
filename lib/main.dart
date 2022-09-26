import 'package:Taskaty/layout/startScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'shared/services/bloc_observer.dart';
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  StartScreen(),
     debugShowCheckedModeBanner: false,
    );
  }
}
