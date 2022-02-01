import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/utils/background_service.dart';
import 'package:resto_app/common/utils/notification_helper.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';
import 'package:resto_app/data/source/resto_database.dart';
import 'package:resto_app/provider/db_provider.dart';
import 'package:resto_app/provider/detail_provider.dart';
import 'package:resto_app/provider/preference_provider.dart';
import 'package:resto_app/provider/resto_provider.dart';
import 'package:resto_app/provider/schedule_provider.dart';
import 'package:resto_app/provider/search_provider.dart';
import 'package:resto_app/ui/screens/favorite_screen.dart';
import 'package:resto_app/ui/screens/search_resto_screen.dart';
import 'package:resto_app/ui/screens/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/screens/detail_resto_screen.dart';
import '../ui/screens/home_resto_screen.dart';
import '../ui/screens/splash.dart';
import 'data/preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(RestoApp());
}

class RestoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestoProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailProvider(apiService: ApiService(), id: ""),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(
          create: (_) => DbProvider(restoDatabase: RestoDatabase()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(
            preferences: Preferences(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
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
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeRestoScreen.routeName: (context) => HomeRestoScreen(),
          SearchRestoScreen.routeName: (context) => SearchRestoScreen(),
          DetailRestoScreen.routeName: (context) => DetailRestoScreen(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          FavoriteScreen.routeName: (context) => FavoriteScreen(
                dbProvider: DbProvider(
                  restoDatabase: RestoDatabase(),
                ),
              ),
          SettingScreen.routeName: (context) => SettingScreen(),
        },
      ),
    );
  }
}
