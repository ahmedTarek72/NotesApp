import 'dart:async';

import 'package:Taskaty/layout/home_screen.dart';
import 'package:flutter/material.dart';

import '../shared/services/reusable_component.dart';
class StartScreen extends StatelessWidget {
   StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2
    ), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/12-months-blue-check-mark-icon-11563057671d6e51m4dr7-removebg-preview.png",width: 100,),
            Text("Taskaty",style: TextStyle( color: mainColor,fontWeight: FontWeight.bold,fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
