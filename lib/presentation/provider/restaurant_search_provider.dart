import 'package:flutter/material.dart';

import '../../data/datasources/remote_datasources/restaurants_datasources.dart';
import '../../data/enum/result_state.dart';
import '../../data/models/restaurant_search_model.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchModel _restaurantSearchResult;
  RestaurantSearchModel get result => _restaurantSearchResult;

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> getSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.founded == 0 &&
          restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();

        return _message = 'Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantSearchResult = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
