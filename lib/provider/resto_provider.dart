import 'package:flutter/material.dart';
import 'package:resto_app/data/source/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestoProvider with ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchDataAllResto();
  }

  late dynamic _restoResponse;
  late ResultState _resultState;
  String _msg = '';

  dynamic get resto => _restoResponse;
  ResultState get state => _resultState;
  String get message => _msg;

  Future<dynamic> _fetchDataAllResto() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final dataRestaurant = await apiService.getRestaurantData();

      if (dataRestaurant.restaurants.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();
        return _msg = 'Failed to load data...';
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();
        return _restoResponse = dataRestaurant.restaurants;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();
      return _msg = 'Something Wrong.. $e';
    }
  }
}