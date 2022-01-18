import 'package:flutter/material.dart';
import 'package:resto_app/model/restaurant.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home_resto";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resto App"),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString("assets/local_restaurant.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Restaurant> restaurant =
                Resto.fromJson(snapshot.data!).restaurants;
            return ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: _localResto(context, restaurant[index]),
                  onTap: () {
                    Navigator.pushNamed(context, "/detail_resto", arguments: restaurant[index]);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Data Tidak Ditemukan !!"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _localResto(BuildContext context, Restaurant restaurant) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                      image: NetworkImage(
                        restaurant.pictureId,
                      ),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(restaurant.name,
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
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(restaurant.rating.toString())
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
