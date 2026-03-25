import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_cart/features/cart/cubit/cart_cubit.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_icons.dart';
import '../../../core/resources/app_text_styles.dart';
import '../model/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  final CartCubit cubit;

  const CartItemWidget({super.key, required this.item, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.strokeColor, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              item.image,
              width: 120,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppTextStyles.main20SemiBold.copyWith(
                            color: AppColors.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () => cubit.removeFromCart(item.id),
                        child: SvgPicture.asset(
                          AppIcons.deleteIcon,
                          width: 20,
                          colorFilter: const ColorFilter.mode(
                              AppColors.mainColor, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EGP ${item.price}",
                        style: AppTextStyles.main14Medium.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => cubit.updateQuantity(
                                  item.id, item.quantity - 1),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              icon: SvgPicture.asset(AppIcons.minusIcon, width: 18),
                            ),
                            Text("${item.quantity}",
                                style: AppTextStyles.white18Medium.copyWith(
                                    fontSize: 14)),
                            IconButton(
                              onPressed: () => cubit.updateQuantity(
                                  item.id, item.quantity + 1),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              icon: SvgPicture.asset(AppIcons.plusIcon2, width: 18),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}