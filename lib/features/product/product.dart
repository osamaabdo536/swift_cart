import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/product/widgets/product_item.dart';
import 'cubit/product_cubit.dart';
import 'cubit/product_state.dart';


class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ProductCubit()..getAllProducts(),
  child: Scaffold(
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
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio:
                      MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 0.70),
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) =>
                    ProductItem(product: state.products[index]),
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
