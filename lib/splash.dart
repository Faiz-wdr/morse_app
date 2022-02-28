import 'dart:async';

import 'package:flutter/material.dart';
import 'package:morse_app/main.dart';
import 'package:morse_app/main.dart';

void main() => runApp(MyApp());

class name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(backgroundColor: Colors.red),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'splash',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 340),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/appIcon.png',
              height: 200,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
