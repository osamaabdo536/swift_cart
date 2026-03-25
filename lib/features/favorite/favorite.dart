import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_cubit.dart';
import 'package:swift_cart/features/favorite/cubit/favorite_state.dart';
import 'package:swift_cart/features/favorite/widgets/favorite_item.dart';
import '../../../core/resources/app_text_styles.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit()..getFavorites(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Favorite",
            style: AppTextStyles.main20SemiBold,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoriteFailureState) {
              return Center(child: Text(state.errMsg));
            }
            if (state is FavoriteSuccessState || state is FavoriteUpdatedState) {
              final favorites = (state is FavoriteSuccessState)
                  ? state.favorites
                  : (state as FavoriteUpdatedState).favorites;

              if (favorites.isEmpty) {
                return const Center(child: Text("No favorites yet"));
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) => FavoriteItem(
                  product: favorites[index],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}