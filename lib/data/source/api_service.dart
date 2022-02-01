import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resto_app/common/constant.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import 'package:resto_app/data/model/resto_response.dart';
import 'package:resto_app/data/model/search_restaurant.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String imageUrl = baseUrl + 'images/medium/';

  Future<RestoResponse> getRestaurantData() async {
    final response = await http.get(Uri.parse(ConstantApp.baseUrl + 'list'));

    if (response.statusCode == 200) {
      return RestoResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestoDetailResponse> getDetailRestaurant(String id) async {
    final response =
        await http.get(Uri.parse(ConstantApp.baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      print('Detail response -> ${json.decode(response.body)}');
      return RestoDetailResponse.detailFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(ConstantApp.baseUrl + "search?q=$query"));

    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
