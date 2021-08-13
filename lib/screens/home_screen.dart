import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:resto/screens/favorite_screen.dart';
import 'package:resto/screens/list_screen.dart';
import 'package:resto/screens/search_screen.dart';
import 'package:resto/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() {
    return [
      ListScreen(),
      SearchScreen(),
      FavoriteScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: 'Home',
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search_outlined),
        title: 'Search',
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_outline),
        title: 'Favorite',
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey[300],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings_outlined),
        title: 'Settings',
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey[300],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItem(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: false,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
