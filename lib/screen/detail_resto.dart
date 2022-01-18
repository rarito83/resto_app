import 'package:flutter/material.dart';
import 'package:resto_app/model/restaurant.dart';

class RestoDetailScreen extends StatelessWidget {
  static const routeName = "/detail_resto";
  final Restaurant restaurant;

  const RestoDetailScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    restaurant.pictureId,
                    width: 450,
                    height: 300,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('City: ${restaurant.city}'),
                  const SizedBox(height: 10.0),
                  Text('Rating: ${restaurant.rating}'),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const Divider(color: Colors.grey),
                  const Text("Makanan:"),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    itemCount: restaurant.menus.foods.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Text(restaurant.menus.foods[index].name);
                    },
                  ),
                  const Divider(color: Colors.grey),
                  const Text("Minuman:"),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    itemCount: restaurant.menus.drinks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Text(restaurant.menus.drinks[index].name);
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
