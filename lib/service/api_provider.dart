import 'dart:convert';
import 'package:commercial_app/models/product.dart';

import 'package:http/http.dart' as https;

class ApiProvider {
  //-------------------------------Get Products--------------------------------------------
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
}
