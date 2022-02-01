
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/provider/db_provider.dart';

import 'list_local_resto.dart';

class ListFavorite extends StatelessWidget {
  static const routeName = '/favorite';

  final DbProvider dbProvider;

  ListFavorite({required this.dbProvider});

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, dbProvider, child) {
        if (dbProvider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: dbProvider.favorites.length,
            itemBuilder: (context, index) {
              return LocalList(restaurant: dbProvider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(dbProvider.message),
          );
        }
      },
    );
  }
}