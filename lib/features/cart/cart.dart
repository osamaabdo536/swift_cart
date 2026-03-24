import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/core/resources/app_icons.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'package:swift_cart/features/cart/widgets/cart_item.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Cart", style: AppTextStyles.main20SemiBold),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (context, index) => const CartItem(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
              top: 10,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total price",
                      style: AppTextStyles.main18Medium.copyWith(
                        color: AppColors.textColor.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      "EGP 3,500",
                      style: AppTextStyles.main20SemiBold.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Check Out",
                          style: AppTextStyles.white18Medium,
                        ),
                        const SizedBox(width: 15),
                        SvgPicture.asset(AppIcons.arrowIcon, width: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
