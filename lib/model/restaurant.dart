import 'dart:convert';

class Resto {
  Resto({
    required this.restaurants,
  });

  final List<Restaurant> restaurants;

  factory Resto.fromJson(String str) => Resto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Resto.fromMap(Map<String, dynamic> json) => Resto(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toMap())),
      };
}

class Restaurant {
  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  factory Restaurant.fromJson(String str) =>
      Restaurant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromMap(json["menus"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toMap()
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Drink> foods;
  final List<Drink> drinks;

  factory Menus.fromJson(String str) => Menus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menus.fromMap(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromMap(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toMap())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toMap())),
      };
}

class Drink {
  Drink({
    required this.name,
  });

  final String name;

  factory Drink.fromJson(String str) => Drink.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Drink.fromMap(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
