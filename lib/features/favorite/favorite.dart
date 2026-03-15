import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_cart/core/resources/app_icons.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'widgets/favorite_item.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppIcons.arrowBackIcon),
        ),
        title: Text(
          "Favorite",
          style: AppTextStyles.main20SemiBold,
        ),
        centerTitle: true,
      ),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) => const FavoriteItem(),
      ),
    );
  }
}