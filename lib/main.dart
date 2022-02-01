import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/ui/screens/search_resto_screen.dart';

import '../ui/screens/detail_resto_screen.dart';
import '../ui/screens/home_resto_screen.dart';
import '../ui/screens/splash.dart';

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
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeRestoScreen.routeName: (context) => HomeRestoScreen(),
        SearchRestoScreen.routeName: (context) => SearchRestoScreen(),
        DetailRestoScreen.routeName: (context) => DetailRestoScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
