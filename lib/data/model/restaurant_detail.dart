import 'package:resto_app/data/model/review.dart';

class RestaurantDetail {
  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
    required this.menus,
    required this.categories,
    required this.address,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String address;
  String pictureId;
  String city;
  double rating;
  String foods;
  String drinks;
  List<Category> categories;
  Menus menus;
  List<Review> customerReviews;

  factory RestaurantDetail.detailFromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<Review>.from(
            json["customerReviews"].map((x) => Review.fromJson(x))),
        drinks: '',
        foods: '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
