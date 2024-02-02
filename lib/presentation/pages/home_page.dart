import 'package:flutter/material.dart';
import 'package:resto_radar/data/enum/result_state.dart';
import 'package:resto_radar/presentation/pages/search_page.dart';
import 'package:resto_radar/presentation/provider/restaurant_list_provider.dart';
import 'package:resto_radar/presentation/widgets/loading_progres_widget.dart';
import 'package:resto_radar/presentation/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

import '../../common/constans.dart';
import '../widgets/error_message.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: Text(
          'Resto Radar',
          style: primaryTextStyle.copyWith(
            fontSize: 25,
          ),
        ),
        backgroundColor: backgroundColor1,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
            icon: Icon(
              Icons.search,
              color: primaryTextColor,
              size: 30,
            ),
          )
        ],
      ),
      body: SafeArea(child: _buildListView()),
    );
  }

  Widget _buildListView() {
    return Consumer<RestaurantListProvider>(
      builder: (_, provider, __) {
        switch (provider.state) {
          case ResultState.loading:
            return const LoadingProgress();
          case ResultState.hasData:
            return ListView.builder(
              itemBuilder: (_, index) {
                final restaurant = provider.result.restaurants[index];
                if (index % 2 == 0) {
                  return RestaurantCardKiri(restaurant);
                } else {
                  return RestaurantCardKanan(restaurant);
                }
              },
            );
          case ResultState.noData:
            return const TextMessage(
              image: 'assets/images/empty-data.png',
              message: 'Data Kosong',
            );
          case ResultState.error:
            return TextMessage(
              image: 'assets/images/no-internet.png',
              message: 'Koneksi Terputus',
              onPressed: () => provider.getAllRestaurant(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
