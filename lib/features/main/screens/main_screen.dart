// main_screen

import 'package:provider/provider.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/main/pages/wishlist_page.dart';
import 'package:stylish/features/main/pages/checkout_screen.dart';
import 'package:stylish/features/main/pages/home_page.dart';
import 'package:stylish/features/location/screens/map_with_location_screen.dart';
import 'package:stylish/features/main/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const [
    HonePage(),
    WishlistPage(),
    //FindAnotherLocationScreen(),
    CheckoutPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBg,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         context.read<AuthController>().signOut();
      //       },
      //       icon: Icon(
      //         Icons.exit_to_app,
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 12.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.grey,
        ),
        selectedIconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 12.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: 'Search',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
