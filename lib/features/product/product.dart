import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_cart/core/resources/app_icons.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';
import 'package:swift_cart/features/cart/cart.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_cubit.dart';
import 'package:swift_cart/features/product/product_details.dart';
import 'package:swift_cart/features/product/widgets/product_item.dart';
import '../../core/resources/app_colors.dart';
import 'cubit/product_cubit.dart';
import 'cubit/product_state.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..getAllProducts(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit()..getFavorites(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: Builder(
            builder: (context) => Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: AppColors.strokeColor, width: 1.5),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context
                            .read<ProductCubit>()
                            .searchProducts(value);
                      },
                      style: AppTextStyles.description14Medium,
                      decoration: InputDecoration(
                        hintText: 'what do you search for?',
                        hintStyle: AppTextStyles.description14light,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.mainColor,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close,
                              color: AppColors.mainColor, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            context
                                .read<ProductCubit>()
                                .searchProducts('');
                          },
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(AppIcons.cartIcon),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductFailureState) {
                return Center(child: Text(state.errMsg));
              }
              if (state is ProductSuccessState) {
                final products = state.filteredProducts;
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      'No products found',
                      style: AppTextStyles.description14Medium,
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height * 0.70),
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: products[index]),
                        ),
                      );
                    },
                    child: ProductItem(product: products[index]),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}