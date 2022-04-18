import 'package:flutter/material.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    MainFoodPage(),
    // SignUpPage(),
    CartHistory(),
    CartPage(),
    AccountPage(),
  ];
  // late PersistentTabController _controller;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }

  // List<Widget> _buildScreens() {
  //   return [
  //     MainFoodPage(),
  //     Container(
  //       child: Center(
  //         child: Text("page 2"),
  //       ),
  //     ),
  //     Container(
  //       child: Center(
  //         child: Text("page 3"),
  //       ),
  //     ),
  //     Container(
  //       child: Center(
  //         child: Text("page 4"),
  //       ),
  //     )
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home_outlined),
  //       title: ("Home"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.black,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.archive_outlined),
  //       title: ("archive"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.black,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.shopping_cart_outlined),
  //       title: ("cart"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.black,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.person_outline),
  //       title: ("person"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.black,
  //     ),
  //   ];
  // }

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: "shoping",
            icon: Icon(Icons.archive_outlined),
          ),
          BottomNavigationBarItem(
            label: "shoping",
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          BottomNavigationBarItem(
            label: "shoping",
            icon: Icon(Icons.person_outline),
          )
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: Colors.white, // Default is Colors.white.
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset:
  //         true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardShows:
  //         true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       colorBehindNavBar: Colors.white,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: ItemAnimationProperties(
  //       // Navigation Bar's items animation properties.
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: ScreenTransitionAnimation(
  //       // Screen transition animation on change of selected tab.
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle:
  //         NavBarStyle.style13, // Choose the nav bar style with this property.
  //   );
  // }
}
