import 'package:fake_store_api/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cart.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(Uri.parse(baseUrl), body: body);
    return response.body;
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

  // Future<APIResponse<List<String>>> getAllCategories() async {
  //   return http.get(Uri.parse('$baseUrl/products/categories')).then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = json.decode(data.body);
  //       final categories = <String>[];
  //       for (var item in jsonData) {
  //         categories.add(item);
  //       }
  //       return APIResponse<List<String>>(data: categories,);
  //     }
  //     return APIResponse<List<String>>( error: true, errorMessage: 'An error occured',);
  //   }).catchError((_) => APIResponse<List<String>>(error: true, errorMessage: 'An error occured',));
  // }

  Future<List<Product>> getAllProducts() async {
    return http.get(Uri.parse('$baseUrl/products'), headers: headers).then((data) {
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

  // Future<APIResponse<List<Product>>> getAllProducts() async {
  //   return http.get(Uri.parse('$baseUrl/products')).then((data) {
  //     if (data.statusCode == 200) {
  //       final jsonData = json.decode(data.body);
  //       final products = <Product>[];
  //       for (var item in jsonData) {
  //         products.add(Product.fromJson(item));
  //       }
  //       return APIResponse<List<Product>>(data: products,);
  //     }
  //     return APIResponse<List<Product>>( error: true, errorMessage: 'An error occured',);
  //   }).catchError((_) => APIResponse<List<Product>>(error: true, errorMessage: 'An error occured',));
  // }

  Future<Product> getProduct(int id) async {
    return http.get(Uri.parse('$baseUrl/products/$id'), headers: headers).then((data) {
      Product product = Product();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        product = Product.fromJson(jsonData);
      }
      return product;
    }).catchError((err) => print(err));
  }



  // Future<Cart> updateCart(int userId, int id) async {
  //   return http.put(Uri.parse('$baseUrl/carts/$id'),
  //     body: json.encode(id.toJson())).then((data) {
  //     Cart cart = Cart();
  //     if (data.statusCode == 204) {
  //       final jsonData = json.encode(data.body);
  //     }
  //     return cart;
  //   }).catchError((err) => print(err));
  // }

  Future<Cart?> getCart(String userId) async {
    return http.get(Uri.parse('$baseUrl/carts/$userId'), headers: headers).then((data) {
      Cart cart = Cart();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        cart = Cart.fromJson(jsonData);
      }
      return cart;
    }).catchError((err) => print(err));
  }

  Future<void> deleteCart(String id) async {
    return http.delete(Uri.parse('$baseUrl/carts/$id'), headers: headers).then((data) {
     if(data.statusCode == 200) {
      final jsonData = json.decode(data.body);
      print(data.statusCode);
      print(jsonData);
     }
    }).catchError((err) => print(err));
  }

}
