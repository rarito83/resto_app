import 'package:resto_app/data/model/restaurant.dart';

class RestoResponse {
  RestoResponse({
    required this.error,
    required this.message,
    this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int? count;
  List<Restaurant> restaurants;

  factory RestoResponse.fromJson(Map<String, dynamic> json) => RestoResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
