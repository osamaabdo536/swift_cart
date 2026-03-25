import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/core/utils/snackbar.dart';
import 'package:swift_cart/features/cart/cubit/cart_cubit.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_icons.dart';
import '../../../core/resources/app_text_styles.dart';
import '../../product/model/products_model.dart';
import '../cubit/favorite_cubit.dart';

class FavoriteItem extends StatelessWidget {
  final ProductModel product;

  const FavoriteItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
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
              product.imageCover,
              width: 120,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: AppTextStyles.main18Medium.copyWith(
                            color: AppColors.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<FavoriteCubit>()
                              .removeFromFavorite(product.id);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                child: SvgPicture.asset(
                                  AppIcons.favoriteFilledIcon,
                                  width: 58,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 4),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "EGP ${product.priceAfterDiscount ?? product.price}",
                            style: AppTextStyles.main18Medium.copyWith(
                              color: AppColors.textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),

                          if (product.priceAfterDiscount != null)
                            Text(
                              "EGP ${product.price}",
                              style: TextStyle(
                                color: AppColors.mainColor.withOpacity(0.5),
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      /// add to cart button
                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () async{
                            final cubit = context.read<CartCubit>();
                            final success = await cubit.addToCart(product.id);
                            if (success) {
                              showSuccess(context, "Added to cart successfully");
                            } else {
                              showError(context, "Failed to add");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            elevation: 0,
                          ),
                          child: Text(
                            "Add to Cart",
                            style: AppTextStyles.white18Medium.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
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