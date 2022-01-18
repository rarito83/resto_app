import 'package:flutter/material.dart';
import 'package:resto_app/model/restaurant.dart';
import 'package:resto_app/screen/detail_resto.dart';
import 'package:resto_app/screen/home_resto.dart';
import 'package:resto_app/screen/splash.dart';

void main() => runApp(RestoApp());

class RestoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        RestoDetailScreen.routeName: (context) => RestoDetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
