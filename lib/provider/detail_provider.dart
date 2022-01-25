import 'package:flutter/material.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/source/api_service.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    fetchDetailResto(id);
  }

  late ResultState _resultState;

  ResultState get state => _resultState;

  dynamic _restoResponse;

  dynamic get resto => _restoResponse;

  String _msg = '';

  String get message => _msg;

  Future<dynamic> fetchDetailResto(String id) async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();

      final data = await apiService.getDetailRestaurant(id);

      if (data.restaurant == null) {
        _resultState = ResultState.NoData;
        notifyListeners();
        return _msg = 'Failed to load data...';
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();
        return _restoResponse = data.restaurant!;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();
      return _msg = 'Something Wrong.. $e';
    }
  }
}
