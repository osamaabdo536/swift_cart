class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://ecommerce.routemisr.com/api/v1/';

  // Auth endpoints
  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  // Note: No logout endpoint available in API

  static const String productsEndPoint = 'products';
  static const String wishlistEndPoint = 'wishlist';

  /////Categories///
  static const String categoriesEndPoint = 'categories';
  /////Categories/////

  //temp token
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5YjViZDI0ZTJmYjI0Y2Y2YTYwNzM5NSIsIm5hbWUiOiJTYW5hYSBBbWVyIEFsaSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzczNjE1ODgyLCJleHAiOjE3ODEzOTE4ODJ9.KwRcWDzJ195du5yT9fHfbiqeOEecb-3BJ_P5firtd78";
}
