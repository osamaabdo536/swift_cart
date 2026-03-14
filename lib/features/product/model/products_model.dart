class ProductsResponse {
  final int results;
  final Metadata metadata;
  final List<ProductModel> data;

  ProductsResponse({
    required this.results,
    required this.metadata,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      results: json['results'],
      metadata: Metadata.fromJson(json['metadata']),
      data: (json['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }
}

class Metadata {
  final int currentPage;
  final int numberOfPages;
  final int limit;
  final int? nextPage;

  Metadata({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    this.nextPage,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
      nextPage: json['nextPage'],
    );
  }
}

class ProductModel {
  final String id;
  final String title;
  final String slug;
  final String description;
  final num price;
  final num? priceAfterDiscount;
  final int quantity;
  final num? sold;
  final String imageCover;
  final List<String> images;
  final double ratingsAverage;
  final int ratingsQuantity;
  final CategoryModel category;
  final List<SubcategoryModel> subcategory;
  final BrandModel brand;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    this.priceAfterDiscount,
    required this.quantity,
    this.sold,
    required this.imageCover,
    required this.images,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.category,
    required this.subcategory,
    required this.brand,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'],
      quantity: json['quantity'],
      sold: json['sold'],
      imageCover: json['imageCover'],
      images: List<String>.from(json['images']),
      ratingsAverage: (json['ratingsAverage'] as num).toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
      category: CategoryModel.fromJson(json['category']),
      subcategory: (json['subcategory'] as List)
          .map((e) => SubcategoryModel.fromJson(e))
          .toList(),
      brand: BrandModel.fromJson(json['brand']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}

class SubcategoryModel {
  final String id;
  final String name;
  final String slug;
  final String category;

  SubcategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
    );
  }
}

class BrandModel {
  final String id;
  final String name;
  final String slug;
  final String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }
}