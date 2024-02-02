import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_radar/common/constans.dart';

import '../provider/database_provider.dart';
import '../../data/enum/result_state.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/error_message.dart';

class RestaurantFavoritesPage extends StatelessWidget {
  static const routeName = '/favorite_page';

  const RestaurantFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: _buildAppBar(context),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor1,
      title: Text(
        'Favorite',
        style: primaryTextStyle.copyWith(
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (_, provider, __) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (_, index) {
              final restaurant = provider.favorites[index];
              if (index % 2 == 0) {
                return RestaurantCardKiri(restaurant);
              } else {
                return RestaurantCardKanan(restaurant);
              }
            },
          );
        } else {
          return TextMessage(
            image: 'assets/images/empty-data.png',
            message: provider.message,
          );
        }
      },
    );
  }
}
