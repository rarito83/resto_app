import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';
import 'package:resto_app/provider/resto_provider.dart';
import 'package:resto_app/ui/screens/search_resto_screen.dart';
import 'package:resto_app/ui/widgets/list_local_resto.dart';

class HomeRestoScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestoProvider>(
      create: (context) => RestoProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Resto App"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchRestoScreen.routeName);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Consumer<RestoProvider>(
          builder: (context, value, _) {
            if (value.state == ResultState.HasData) {
              final List<Restaurant> restaurants = value.resto;
              return ListView.builder(
                itemCount: value.resto.length,
                itemBuilder: (context, index) {
                  return LocalList(
                    restaurant: restaurants[index],
                  );
                },
              );
            } else if (value.state == ResultState.Error) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          "Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
                      ElevatedButton(
                        onPressed: () {
                          value.fetchDataAllResto();
                        },
                        child: const Text('Refresh'),
                      ),
                    ],
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
