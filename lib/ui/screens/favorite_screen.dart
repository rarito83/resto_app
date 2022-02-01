import 'package:flutter/material.dart';
import 'package:resto_app/data/source/resto_database.dart';
import 'package:resto_app/provider/db_provider.dart';
import 'package:resto_app/ui/widgets/list_favorite.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorites';

  final DbProvider dbProvider;

  FavoriteScreen({required this.dbProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorite',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )),
      body: ListFavorite(
        dbProvider: DbProvider(
          restoDatabase: RestoDatabase(),
        ),
      ),
    );
  }
}
