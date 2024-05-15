import 'package:ewallet/Screens/pages/Dashboard.dart';
import 'package:ewallet/Screens/pages/Profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Models/User.dart';
import '../pages/walletsPage.dart';

class NavBar extends StatelessWidget {
  NavBar(this.user, {super.key});

  User user;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "home",
        activeColorPrimary: const Color(0xFF404CB2),
        inactiveColorPrimary: const Color(0Xff94AFB6),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.wallet),
        title: "wallets",
        activeColorPrimary: const Color(0xFF404CB2),
        inactiveColorPrimary: const Color(0Xff94AFB6),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        title: "myProfile",
        activeColorPrimary: const Color(0xFF404CB2),
        inactiveColorPrimary: const Color(0Xff94AFB6),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [Dashboard(user), WalletsPage(user), const Profile()];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.simple,
      // Choose the nav bar style with this property.
    );
  }
}
