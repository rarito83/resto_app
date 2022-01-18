import 'dart:async';

import 'package:flutter/material.dart';

import 'home_resto.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/resto.jpeg", width: 100),
            const SizedBox(height: 24.0),
            const Text(
              "Resto App",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
