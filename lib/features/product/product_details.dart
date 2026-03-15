import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/core/resources/app_icons.dart';
import 'package:swift_cart/features/cart/cart.dart';
import 'package:swift_cart/features/product/model/products_model.dart';
import 'package:swift_cart/features/product/widgets/product_slider.dart';
import '../../core/resources/app_text_styles.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details", style: AppTextStyles.main20Medium),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ),
                );
              },
              child: SvgPicture.asset(AppIcons.cartIcon),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductSlider(images: widget.product.images),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title,
                        style: AppTextStyles.main18Medium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "EGP ${widget.product.priceAfterDiscount ?? widget.product.price}",
                      style: AppTextStyles.main18Medium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.strokeColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${(widget.product.sold ?? 0) > 1000 ? '1000+' : widget.product.sold?.toInt() ?? 0} Sold",
                            style: AppTextStyles.main14Medium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})",
                          style: AppTextStyles.main14Medium,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) setState(() => quantity--);
                            },
                            child: SvgPicture.asset(AppIcons.detailsMinusIcon),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$quantity',
                              style: AppTextStyles.white18Medium,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => quantity++),
                            child: SvgPicture.asset(AppIcons.detailsPlusIcon),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.product.brand.image,
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.width * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Brand",
                          style: AppTextStyles.main18Medium.copyWith(
                            color: AppColors.textColor.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          widget.product.brand.name,
                          style: AppTextStyles.main18Medium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Description", style: AppTextStyles.main18Medium),
                const SizedBox(height: 4),
                Text(
                  widget.product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.description14Medium,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
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
                        "EGP ${widget.product.price * quantity}",
                        style: AppTextStyles.main20SemiBold.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_shopping_cart_outlined,
                          color: AppColors.whiteColor,
                        ),
                        SizedBox(width: 20),
                        const Text(
                          "Add to cart",
                          style: AppTextStyles.white18Medium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
