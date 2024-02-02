import 'package:flutter/material.dart';

import '../../data/datasources/remote_datasources/restaurants_datasources.dart';
import '../../data/enum/result_state.dart';
import '../../data/models/restaurant_list_model.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    getAllRestaurant();
  }

  late RestaurantListModel _restaurantListResult;
  RestaurantListModel get result => _restaurantListResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> getAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.count == 0 && restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantListResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
