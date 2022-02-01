import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/resto_database.dart';
import 'package:resto_app/provider/db_provider.dart';
import 'package:resto_app/provider/resto_provider.dart';
import 'package:resto_app/ui/screens/search_resto_screen.dart';
import 'package:resto_app/ui/screens/setting_screen.dart';
import 'package:resto_app/ui/widgets/list_local_resto.dart';

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

  List<Widget> _listBar = [
    HomeRestoScreen(),
    FavoriteScreen(
      dbProvider: databaseProvider,
    ),
    SettingScreen(),
  ];

  @override
  void initState() {
    navIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resto App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchRestoScreen.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<RestoProvider>(
        builder: (context, value, _) {
          if (value.state == ResultState.hasData) {
            final List<Restaurant> restaurants = value.resto;
            return ListView.builder(
              itemCount: value.resto.length,
              itemBuilder: (context, index) {
                return LocalList(
                  restaurant: restaurants[index],
                );
              },
            );
          } else if (value.state == ResultState.error) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
                ElevatedButton(
                  onPressed: () {
                    value.fetchDataAllResto();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
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
        items: [
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
}
