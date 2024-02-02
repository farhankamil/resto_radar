import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:resto_radar/common/constans.dart';

import '../../data/enum/result_state.dart';
import '../provider/restaurant_search_provider.dart';
import '../widgets/loading_progres_widget.dart';
import '../widgets/error_message.dart';
import '../widgets/restaurant_card.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const String routeName = '/search_page';

  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pencarian',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        backgroundColor: backgroundColor1,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Cari nama restoran',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onSubmitted: (query) {
                if (query != '') {
                  Provider.of<RestaurantSearchProvider>(
                    context,
                    listen: false,
                  ).getSearchRestaurant(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (_, provider, __) {
                switch (provider.state) {
                  case ResultState.loading:
                    return const LoadingProgress();
                  case ResultState.hasData:
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: provider.result.restaurants.length,
                      itemBuilder: (_, index) {
                        final restaurant = provider.result.restaurants[index];
                        if (index % 2 == 0) {
                          return RestaurantCardKiri(restaurant);
                        } else {
                          return RestaurantCardKanan(restaurant);
                        }
                      },
                    );
                  case ResultState.error:
                    return const TextMessage(
                      image: 'assets/images/no-internet.png',
                      message: 'Periksa Koneksi Anda',
                    );
                  case ResultState.noData:
                    return const TextMessage(
                      image: 'assets/images/not-found.png',
                      message: 'Pencarian tidak ditemukan',
                    );
                  default:
                    return const TextMessage(
                      image: 'assets/images/search.png',
                      message: 'Silahkan lakukan pencarian',
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
