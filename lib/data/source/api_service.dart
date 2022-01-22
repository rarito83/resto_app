import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resto_app/common/constant.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/resto_response.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String imageUrl = baseUrl + 'images/medium/';

  Future<RestoResponse> getRestaurantData() async {
    final response = await http.get(Uri.parse(ConstantApp.baseUrl + 'list'));

    if (response.statusCode == 200) {
      return RestoResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.toString());
    }
  }

  Future<Restaurant> getDetailRestaurant(String id) async {
    final response =
        await http.get(Uri.parse(ConstantApp.baseUrl + "detail/" + "id"));

    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.toString());
    }
  }

  Future<RestoResponse> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(ConstantApp.baseUrl + "search?$query"));

    if (response.statusCode == 200) {
      return RestoResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.toString());
    }
  }
}
