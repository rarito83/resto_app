import 'package:resto_app/data/model/restaurant.dart';

class RestoResponse {
  RestoResponse({
    required this.error,
    required this.message,
    this.count,
    this.restaurants,
    this.restaurant,
  });

  bool error;
  String message;
  int? count;
  List<Restaurant>? restaurants;
  Restaurant? restaurant;

  factory RestoResponse.fromJson(Map<String, dynamic> json) => RestoResponse(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(
      json["restaurants"].map((x) => Restaurant.fromJson(x)),
    ),
  );

  factory RestoResponse.detailFromJson(Map<String, dynamic> json) =>
      RestoResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.detailFromJson(json["restaurant"]),
      );
}
