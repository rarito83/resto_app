import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';
import 'package:resto_app/data/source/resto_database.dart';
import 'package:resto_app/provider/db_provider.dart';
import 'package:resto_app/provider/detail_provider.dart';

class DetailRestoScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  final Restaurant restaurant;

  DetailRestoScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailProvider>(
          create: (context) =>
              DetailProvider(apiService: ApiService(), id: restaurant.id),
        ),
        ChangeNotifierProvider<DbProvider>(
          create: (context) => DbProvider(restoDatabase: RestoDatabase()),
        ),
      ],
      child: Consumer<DbProvider>(builder: (context, provider, _) {
        return FutureBuilder<bool>(
            future: provider.isFavourite(restaurant.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Detail Restaurant'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        isFavorited
                            ? IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    provider.removeFavorites(restaurant.id),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    provider.addFavorite(restaurant),
                              );
                      },
                      icon: const Icon(Icons.favorite),
                    ),
                  ],
                ),
                body: Consumer<DetailProvider>(builder: (context, value, _) {
                  if (value.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (value.state == ResultState.noData) {
                    return Center(
                      child: Text(value.state.toString()),
                    );
                  } else if (value.state == ResultState.error) {
                    return const Center(
                      child: Text(
                          "Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
                    );
                  } else if (value.state == ResultState.hasData) {
                    final detail = value.resto.restaurant;
                    print("Detail ==> $detail");
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Hero(
                                tag: restaurant.pictureId,
                                child: Image.network(
                                  ApiService.imageUrl + restaurant.pictureId,
                                  width: 450,
                                  height: 300,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Consumer<DbProvider>(
                              builder: (context, provider, _) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    const Divider(color: Colors.grey),
                                    Text('City: ${detail.city}'),
                                    const SizedBox(height: 10.0),
                                    Text('Rating: ${detail.rating}'),
                                    const Divider(color: Colors.grey),
                                    Text(
                                      detail.description,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    const Divider(color: Colors.grey),
                                    const Text("Makanan:"),
                                    const SizedBox(height: 10.0),
                                    ListView.builder(
                                      itemCount: detail.menus.foods.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Text(
                                            detail.menus.foods[index].name);
                                      },
                                    ),
                                    const Divider(color: Colors.grey),
                                    const Text("Minuman:"),
                                    const SizedBox(height: 10.0),
                                    ListView.builder(
                                      itemCount: detail.menus.drinks.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Text(
                                            detail.menus.drinks[index].name);
                                      },
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
              );
            });
      }),
    );
  }
}
