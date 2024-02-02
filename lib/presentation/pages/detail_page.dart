import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_radar/data/datasources/remote_datasources/restaurants_datasources.dart';
import 'package:resto_radar/data/enum/result_state.dart';
import 'package:resto_radar/presentation/provider/restaurant_detail_provider.dart';
import 'package:http/http.dart' as http;
import 'package:resto_radar/presentation/widgets/detail_restaurant_widget.dart';
import 'package:resto_radar/presentation/widgets/loading_progres_widget.dart';

import '../../common/constans.dart';
import '../../data/models/restaurant_list_model.dart';
import '../widgets/error_message.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(http.Client()),
        restaurantId: restaurant.id,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (_, provider, __) {
            switch (provider.state) {
              case ResultState.loading:
                return const LoadingProgress();
              case ResultState.hasData:
                return ContentRestaurant(
                  provider: provider,
                  restaurant: provider.result.restaurant,
                );
              case ResultState.error:
                return TextMessage(
                  image: 'assets/images/no-internet.png',
                  message: 'Koneksi Terputus',
                  onPressed: () =>
                      provider.fetchDetailRestaurant(restaurant.id),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: _buttonBack(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _buttonBack(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
        left: 5.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
