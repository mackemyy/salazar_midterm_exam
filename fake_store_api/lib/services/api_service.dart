import 'package:fake_store_api/models/product.dart';
import 'package:fake_store_api/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cart.dart';
import '../models/cart_update.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login(String uname, String pword) async {
    final credentials = User(username: uname, password: pword);
    return http
        .post(Uri.parse('$baseUrl/auth/login'),
            headers: headers, body: json.encode(credentials.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
      return null;
    });
  }

  Future<List<String>> getAllCategories() async {
    return http.get(Uri.parse('$baseUrl/products/categories')).then((data) {
      final categories = <String>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          categories.add(item);
        }
      }
      return categories;
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getAllProducts() async {
    return http
        .get(Uri.parse('$baseUrl/products'), headers: headers)
        .then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<Product> getProduct(int id) async {
    return http
        .get(Uri.parse('$baseUrl/products/$id'), headers: headers)
        .then((data) {
      Product product = Product();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        product = Product.fromJson(jsonData);
      }
      return product;
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getProductsByCategory(String categoryName) async {
    return http
        .get(Uri.parse('$baseUrl/products/category/$categoryName'),
            headers: headers)
        .then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          if (item['category'] == categoryName) {
            products.add(Product.fromJson(item));
          }
        }
      }
      return products;
    });
  }

  Future<void> updateCart(int cartId, int productId) {
    final cartUpdate =
        CartUpdate(userId: cartId, date: DateTime.now(), products: [
      {'productId': productId, 'quantity': 1}
    ]);
    return http
        .put(Uri.parse('$baseUrl/carts/$cartId'),
            headers: headers, body: json.encode(cartUpdate.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(data.statusCode);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }

  Future<Cart?> getCart(String userId) async {
    return http
        .get(Uri.parse('$baseUrl/carts/$userId'), headers: headers)
        .then((data) {
      Cart cart = Cart();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        cart = Cart.fromJson(jsonData);
      }
      return cart;
    }).catchError((err) => print(err));
  }

  Future<void> deleteCart(String id) async {
    return http
        .delete(
      Uri.parse('$baseUrl/carts/$id'),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(data.statusCode);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }
}
