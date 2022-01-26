import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/common/result_state.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/source/api_service.dart';
import 'package:resto_app/provider/search_provider.dart';
import 'package:resto_app/ui/screens/detail_resto_screen.dart';

class SearchRestoScreen extends StatelessWidget {
  static const routeName = '/search_screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (context) => SearchProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Consumer<SearchProvider>(
            builder: (context, value, _) => Column(
              children: [
                TextField(
                  onSubmitted: (text) {
                    if (text.isEmpty) return;
                    value.searchResto = text;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Search Restaurant by Name...',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<SearchProvider>(
                    builder: (context, value, _) {
                      if (value.state == ResultState.hasData) {
                        final List<Restaurant> data =
                            value.restoSearch!.restaurants;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            8.0, 4.0, 8.0, 8.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                              Radius.circular(10.0)),
                                          child: Hero(
                                            tag: data[index].pictureId,
                                            child: Image.network(
                                              ApiService.imageUrl +
                                                  data[index].pictureId,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            data[index].name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                          ),
                                          const SizedBox(height: 3.0),
                                          Text(
                                            data[index].city,
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
                                                data[index].rating.toString(),
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
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, DetailRestoScreen.routeName,
                                    arguments: data[index]);
                              },
                            );
                          },
                        );
                      } else if (value.state == ResultState.error) {
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                    "Jaringan Terputus!! Periksa Koneksi Internet Anda.."),
                              ],
                            ));
                      } else if (value.state == ResultState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Icon(Icons.search_outlined, size: 60);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
