import 'package:resto_app/data/model/restaurant_detail.dart';

class RestoDetailResponse {
  RestoDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetail restaurant;

  factory RestoDetailResponse.detailFromJson(Map<String, dynamic> json) =>
      RestoDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.detailFromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
