import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/features/prodcut/favorite.dart';
import 'package:swift_cart/features/prodcut/product.dart';
import 'package:swift_cart/features/profile/profile.dart';

import 'core/resources/app_icons.dart';
import 'features/home/home.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int currentIndex = 0;
  List<Widget> tabs = [Home(), Product(), Favorite(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: AppColors.mainColor,
          items: [
            BottomNavigationBarItem(
              label: "home",
              activeIcon: SvgPicture.asset(AppIcons.homeCircleIcon),
              icon: SvgPicture.asset(AppIcons.homeIcon),
            ),
            BottomNavigationBarItem(
              label: "product",
              activeIcon: SvgPicture.asset(AppIcons.productCircleIcon),
              icon: SvgPicture.asset(AppIcons.productIcon),
            ),
            BottomNavigationBarItem(
              label: "favorite",
              activeIcon: SvgPicture.asset(AppIcons.favoriteCircleIcon),
              icon: SvgPicture.asset(AppIcons.favoriteIcon),
            ),
            BottomNavigationBarItem(
              label: "profile",
              activeIcon: SvgPicture.asset(AppIcons.profileCircleIcon),
              icon: SvgPicture.asset(AppIcons.profileIcon),
            ),
          ],
        ),
      ),
    );
  }
}
