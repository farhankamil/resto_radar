import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:resto_radar/common/navigation.dart';

import 'package:resto_radar/data/datasources/remote_datasources/restaurants_datasources.dart';
import 'package:resto_radar/data/db/database_helper.dart';
import 'package:resto_radar/data/models/restaurant_list_model.dart';
import 'package:resto_radar/presentation/pages/home_page.dart';
import 'package:resto_radar/presentation/pages/main_navigation.dart';
import 'package:resto_radar/presentation/provider/database_provider.dart';
import 'package:resto_radar/presentation/provider/restaurant_list_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/preferences/preferences_helper.dart';
import 'presentation/pages/detail_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/provider/preferences_provider.dart';
import 'presentation/provider/restaurant_search_provider.dart';
import 'presentation/provider/scheduling_provider.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: MainNavigation.routeName,
        routes: {
          MainNavigation.routeName: (_) => const MainNavigation(),
          HomePage.routeName: (_) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          RestaurantSearchPage.routeName: (_) => const RestaurantSearchPage(),
        },
      ),
    );
  }
}
