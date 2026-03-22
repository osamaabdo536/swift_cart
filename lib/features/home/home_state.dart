abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final List<dynamic> products;
  final List<dynamic> categories;
  final List<dynamic> brands;
  HomeSuccessState(this.products, this.categories, this.brands);
}

class HomeErrorState extends HomeStates {
  final String error;
  HomeErrorState(this.error);
}
