import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/restaurant.dart';
import '../ui/screens/detail_resto_screen.dart';
import '../ui/screens/splash.dart';
import '../ui/screens/home_resto_screen.dart';
import '../data/source/api_service.dart';
import '../provider/resto_provider.dart';

void main() => runApp(RestoApp());

class RestoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestoProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Resto App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeRestoScreen.routeName: (context) => HomeRestoScreen(),
          DetailRestoScreen.routeName: (context) => DetailRestoScreen(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}
