import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';
import 'package:resto_app/provider/detail_provider.dart';

class DetailRestoScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  final Restaurant restaurant;

  DetailRestoScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (context) =>
          DetailProvider(apiService: ApiService(), id: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Restaurant'),
          centerTitle: true,
        ),
        body: Consumer<DetailProvider>(builder: (context, value, _) {
          if (value.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.state == ResultState.NoData) {
            return Center(
              child: Text(value.state.toString()),
            );
          } else if (value.state == ResultState.Error) {
            return const Center(
              child:
              Text("Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
            );
          } else if (value.state == ResultState.HasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    child: Hero(
                        tag: value.resto.id,
                        child: Image.network(
                          ApiService.imageUrl + value.resto.id,
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
                          value.resto.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Text('City: ${value.resto.city}'),
                        const SizedBox(height: 10.0),
                        Text('Rating: ${value.resto.rating}'),
                        const Divider(color: Colors.grey),
                        Text(
                          value.resto.description,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
