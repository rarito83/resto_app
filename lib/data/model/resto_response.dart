import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/restaurant_detail.dart';

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
  RestaurantDetail? restaurant;

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
        restaurant: RestaurantDetail.detailFromJson(json["restaurant"]),
      );
}
