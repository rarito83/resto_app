import 'package:flutter/material.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/search_restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  SearchRestaurant? _restoSearch;

  SearchRestaurant? get restoSearch => _restoSearch;

  ResultState? _resultState;

  ResultState? get state => _resultState;

  String _msg = '';

  String get message => _msg;

  String _search = '';

  String get search => _search;

  set searchResto(String query) {
    _search = query;
    notifyListeners();
    getRestaurantSearch(query);
  }

  Future<dynamic> getRestaurantSearch(String query) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.searchRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _msg = 'Tidak ditemukan';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restoSearch = restaurantSearch;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _msg = 'Something Wrong.. $e';
    }
  }
}
