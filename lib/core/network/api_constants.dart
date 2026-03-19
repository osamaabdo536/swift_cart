class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://ecommerce.routemisr.com/';

  // Auth endpoints
  static const String login = 'api/v1/auth/signin';
  static const String register = 'api/v1/auth/signup';
  // Note: No logout endpoint available in API

  // Product endpoints
  static const String productsEndPoint = 'api/v1/products';
  static const String wishlistEndPoint = 'api/v1/wishlist';

  //temp token
  static const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5YjViZDI0ZTJmYjI0Y2Y2YTYwNzM5NSIsIm5hbWUiOiJTYW5hYSBBbWVyIEFsaSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzczNjE1ODgyLCJleHAiOjE3ODEzOTE4ODJ9.KwRcWDzJ195du5yT9fHfbiqeOEecb-3BJ_P5firtd78";
}
