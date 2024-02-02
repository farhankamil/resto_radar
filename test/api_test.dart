import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:resto_radar/data/datasources/remote_datasources/restaurants_datasources.dart';
import 'package:resto_radar/data/models/restaurant_detail_model.dart';
import 'package:resto_radar/data/models/restaurant_list_model.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String getAllRestaurant = '''
  {
    "error": false,
    "message": "success",
    "count": 2,
    "restaurants": [
      {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2
      },
      {
        "id": "s1knt6za9kkfw1e867",
        "name": "Kafe Kita",
        "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
        "pictureId": "25",
        "city": "Gorontalo",
        "rating": 4
      }
    ]
  }
  ''';

  const String getDetailRestaurant = '''
  {
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
      "city": "Medan",
      "address": "Jln. Pandeglang no 19",
      "pictureId": "14",
      "categories": [
        {
          "name": "Italia"
        },
        {
          "name": "Modern"
        }
      ],
      "menus": {
        "foods": [
          {
            "name": "Paket rosemary"
          },
          {
            "name": "Toastie salmon"
          }
        ],
        "drinks": [
          {
            "name": "Es krim"
          },
          {
            "name": "Sirup"
          }
        ]
      },
      "rating": 4.2,
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        }
      ]
    }
  }
  ''';

  group('Test API', () {
    final MockClient client = MockClient();
    final ApiService apiService = ApiService(client);

    test('json parsing all restaurant', () async {
      when(client.get(Uri.parse('${ApiService.baseUrl}/list')))
          .thenAnswer((_) async => http.Response(getAllRestaurant, 200));

      expect(await apiService.getRestaurantList(), isA<RestaurantListModel>());
    });

    test('json parsing detail restaurant by id', () async {
      const String id = 's1knt6za9kkfw1e867';

      when(client.get(Uri.parse('${ApiService.baseUrl}/detail/$id')))
          .thenAnswer((_) async => http.Response(getDetailRestaurant, 200));

      expect(
        await apiService.getDetail(id),
        isA<RestaurantDetailModel>(),
      );
    });
  });
}
