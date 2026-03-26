import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_cart/features/cart/cart.dart';
import 'package:swift_cart/features/category/view/category_products_screen.dart';
import 'package:swift_cart/features/home/all_categories.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'category_item.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:swift_cart/core/resources/app_colors.dart';
import 'package:swift_cart/core/resources/app_icons.dart';
import 'package:swift_cart/core/resources/app_images.dart';
import 'package:swift_cart/core/resources/app_text_styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sliderImages = [
      AppImages.slider1,
      AppImages.slider2,
      AppImages.slider3,
    ];
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeSuccessState) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Swift Cart",
                                  style: AppTextStyles.main20SemiBold.copyWith(
                                    fontSize: 24,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CartPage(),
                                      ),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    AppIcons.cartIcon,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.mainColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 160.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            viewportFraction: 0.9,
                          ),
                          items: sliderImages.map((imagepath) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                imagepath,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Categories",
                              style: AppTextStyles.description18Medium,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllCategoriesScreen(
                                      categories: state.categories,
                                    ),
                                  ),
                                );
                              },

                              child: const Text(
                                "view all",
                                style: AppTextStyles.main14Regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.8,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        var cat = state.categories[index];
                        String finalImagePath =
                            (cat['name'] == "Women's Fashion")
                            ? "assets/images/fashion-photo.jpg"
                            : cat['image'];
                        return CategoryItem(
                          title: cat['name'],
                          imagePath: finalImagePath,

                          id: cat['_id'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductsScreen(
                                  categoryId: cat['_id'],
                                  categoryName: cat['name'],
                                ),
                              ),
                            );
                          },
                        );
                      }, childCount: state.categories.length),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          "Brands",
                          style: AppTextStyles.description18Medium,
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          itemCount: state.brands.length,
                          itemBuilder: (context, index) {
                            var brand = state.brands[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.strokeColor,
                                  ),
                                ),

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        brand['image'] ??
                                            "https://via.placeholder.com/150",
                                      ),
                                    ),
                                    Text(
                                      brand['name'] ?? "brand",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                );
              } else if (state is HomeErrorState) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
