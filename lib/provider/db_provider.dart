import 'package:flutter/material.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/resto_database.dart';

class DbProvider extends ChangeNotifier {
  late RestoDatabase restoDatabase;

  DbProvider({required this.restoDatabase}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultState.loading;
    notifyListeners();
    _favorites = await restoDatabase.getFavourite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'List Favoritmu Masih Kosong!';
    }
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    try {
      await restoDatabase.insertFavourite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final favouriteRestaurant = await restoDatabase.getFavoriteById(id);
    return favouriteRestaurant.isNotEmpty;
  }

  void removeFavorites(String id) async {
    try {
      await restoDatabase.deleteRestaurant(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}