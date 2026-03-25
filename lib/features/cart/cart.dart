import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_cart/features/cart/checkout_dialog.dart';
import 'package:swift_cart/features/cart/cubit/cart_cubit.dart';
import 'package:swift_cart/features/cart/cubit/cart_state.dart';
import 'package:swift_cart/features/cart/widgets/cart_item.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_icons.dart';
import '../../../core/resources/app_text_styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text("Cart", style: AppTextStyles.main20SemiBold),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (state is CartLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CartFailureState) {
                        return Center(child: Text(state.errMsg));
                      }
                      if (state is CartSuccessState) {
                        if (state.cartItems.isEmpty) {
                          return const Center(child: Text("Your cart is empty"));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) => CartItemWidget(
                            item: state.cartItems[index],
                            cubit: cubit,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
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
                            "EGP ${cubit.totalPrice.toStringAsFixed(2)}",
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const CheckoutDialog(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Check Out",
                                  style: AppTextStyles.white18Medium),
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
        },
    );
  }
}