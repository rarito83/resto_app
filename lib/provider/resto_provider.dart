import 'package:flutter/material.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/source/api_service.dart';

class RestoProvider with ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    fetchDataAllResto();
  }

  late ResultState _resultState;

  ResultState get state => _resultState;

  late dynamic _restoResponse;

  dynamic get resto => _restoResponse;

  String _msg = '';

  String get message => _msg;

  Future<dynamic> fetchDataAllResto() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final dataRestaurant = await apiService.getRestaurantData();

      if (dataRestaurant.restaurants!.isEmpty) {
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
