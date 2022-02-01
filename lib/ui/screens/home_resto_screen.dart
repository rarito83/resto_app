import 'package:flutter/material.dart';
import 'package:resto_app/common/utils/notification_helper.dart';
import 'package:resto_app/data/source/resto_database.dart';
import 'package:resto_app/provider/db_provider.dart';
import 'package:resto_app/ui/screens/detail_resto_screen.dart';
import 'package:resto_app/ui/screens/resto_screen.dart';
import 'package:resto_app/ui/screens/search_resto_screen.dart';
import 'package:resto_app/ui/screens/setting_screen.dart';

import 'favorite_screen.dart';

class HomeRestoScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  @override
  State<HomeRestoScreen> createState() => _HomeRestoScreenState();
}

class _HomeRestoScreenState extends State<HomeRestoScreen> {
  static DbProvider databaseProvider =
      DbProvider(restoDatabase: RestoDatabase());

  late int navIndex;
  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listBar = [
    RestoScreen(),
    FavoriteScreen(
      dbProvider: databaseProvider,
    ),
    SettingScreen(),
  ];

  @override
  void initState() {
    _notificationHelper
        .configureSelectNotificationSubject(context, DetailRestoScreen.routeName);
    navIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listBar[navIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        currentIndex: navIndex,
        onTap: (value) {
          setState(() {
            navIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
