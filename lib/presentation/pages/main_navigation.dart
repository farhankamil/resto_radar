import 'package:flutter/material.dart';
import 'package:resto_radar/common/constans.dart';
import 'package:resto_radar/presentation/pages/favorite_page.dart';
import 'package:resto_radar/presentation/pages/home_page.dart';
import 'package:resto_radar/presentation/pages/setting_page.dart';
import 'package:resto_radar/utils/notification_helper.dart';

class MainNavigation extends StatefulWidget {
  static const routeName = '/main';
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _bottonIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems =
        const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '',
      ),
    ];

    const List<Widget> bottomNavScreen = <Widget>[
      HomePage(),
      RestaurantFavoritesPage(),
      SettingPage(),
    ];

    void onButtonNavigationTap(int index) {
      setState(
        () {
          _bottonIndex = index;
        },
      );
    }

    return Scaffold(
      body: bottomNavScreen[_bottonIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        selectedItemColor: primaryColor,
        currentIndex: _bottonIndex,
        onTap: onButtonNavigationTap,
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
