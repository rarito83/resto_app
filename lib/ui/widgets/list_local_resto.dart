import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';

Widget localList(BuildContext context, Restaurant restaurant) {
  return Card(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  ApiService.imageUrl + restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                restaurant.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                restaurant.city,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
