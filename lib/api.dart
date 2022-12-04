


class Api{

  static const String baseUrl = 'http://192.168.0.110:3000';
  static const String login = '$baseUrl/api/userLogin';
  static const String signUp = '$baseUrl/api/userSignUp';
  static const String addProduct = '$baseUrl/api/create_products';
  static const String updateProduct = '$baseUrl/product/update';
  static const String removeProduct = '$baseUrl/products/remove';
  static const String orderHistory = '$baseUrl/order/history';
  static const String orderCreate = '$baseUrl/order/order_create';
}