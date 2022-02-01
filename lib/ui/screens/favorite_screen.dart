import 'package:flutter/material.dart';
import 'package:resto_app/provider/db_provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorites';

  final DbProvider dbProvider;

  FavoriteScreen({required this.dbProvider});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
