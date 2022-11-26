import 'dart:convert';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/models/user.dart';
import 'package:http/http.dart' as https;

class ApiProvider {
  //-------------------------------Get Products--------------------------------------------

  Future<List<ProductItem>> getProductsList() async {
    try {
      https.Response response =
          await https.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        List<ProductItem> products = (jsonDecode(response.body) as List?)
                ?.map((e) => ProductItem.fromJson(e))
                .toList() ??
            [];
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductItem>> getLimitedProduct({required limitedCount}) async {
    try {
      https.Response response = await https.get(
          Uri.parse("https://fakestoreapi.com/products?limit=$limitedCount"));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<ProductItem> products = (jsonDecode(response.body) as List?)
                ?.map((e) => ProductItem.fromJson(e))
                .toList() ??
            [];
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> getAllCategories() async {
    try {
      https.Response response = await https
          .get(Uri.parse("https://fakestoreapi.com/products/categories"));
      if (response.statusCode == 200) {
        List<String> categories = (jsonDecode(response.body) as List?)
                ?.map((e) => e as String)
                .toList() ??
            [];
        return categories;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductItem>> getSelectCategory(
      {required String categoryName}) async {
    try {
      https.Response response = await https.get(Uri.parse(
          "https://fakestoreapi.com/products/category/$categoryName"));
      if (response.statusCode == 200) {
        List<ProductItem> selectedCategories =
            (jsonDecode(response.body) as List?)
                    ?.map((e) => ProductItem.fromJson(e))
                    .toList() ??
                [];
        return selectedCategories;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//----------------------------------------------Get Users-------------------------------------------------
  static Future<List<User>> getAllUsers() async {
    try {
      https.Response response =
          await https.get(Uri.parse("https://fakestoreapi.com/users"));
      if (response.statusCode == 200) {
        List<User> user = (jsonDecode(response.body) as List?)
                ?.map((e) => User.fromJson(e))
                .toList() ??
            [];
        return user;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
