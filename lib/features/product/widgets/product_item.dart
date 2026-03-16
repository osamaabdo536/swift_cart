import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_cubit.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_state.dart';
import '../../../core/resources/app_icons.dart';
import '../../../core/resources/app_text_styles.dart';
import '../model/products_model.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
Widget build(BuildContext context) {
  return BlocBuilder<FavoriteCubit, FavoriteState>(
    builder: (context, state) {

      final favoriteCubit = context.read<FavoriteCubit>();

      bool isFav = favoriteCubit.favoriteIds.contains(widget.product.id);

      return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                widget.product.imageCover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    /// add to favorite logic
                      if (isFav) {
                        context.read<FavoriteCubit>().removeFromFavorite(widget.product.id);
                      } else {
                        context.read<FavoriteCubit>().addToFavorite(widget.product.id);
                      }
                  },
                  child: isFav
                      ? SvgPicture.asset(AppIcons.favoriteFilledIcon)
                      : SvgPicture.asset(AppIcons.favoriteCircleIcon),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.main14Regular,
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Text(
                      "EGP ${widget.product.priceAfterDiscount ?? widget.product.price}",
                      style: AppTextStyles.main14Regular,
                    ),
                    const SizedBox(width: 6),
                    if (widget.product.priceAfterDiscount != null)
                      Text(
                        "EGP ${widget.product.price}",
                        style: AppTextStyles.main12Regular.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Review ", style: AppTextStyles.main12Regular),
                        Text(
                          widget.product.ratingsAverage.toString(),
                          style: AppTextStyles.main12Regular,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        /// add to cart logic
                      },
                      child: SvgPicture.asset(AppIcons.plusIcon),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
    );
  }
}