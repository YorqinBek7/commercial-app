import 'dart:convert';
import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as https;
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  int isSelected = -1;
  List<ProductItem> allProducts = [];
  List<SelectedProducts> storageProducts = [];
  Future<List<ProductItem>> getProductsList() async {
    emit(ProductsLoading());
    try {
      https.Response response =
          await https.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        List<ProductItem> products = (jsonDecode(response.body) as List?)
                ?.map((e) => ProductItem.fromJson(e))
                .toList() ??
            [];
        emit(ProductsSuccess(products: products));
        return products;
      } else {
        emit(ProductsError(error: 'error'));
        return [];
      }
    } catch (e) {
      emit(ProductsError(error: e.toString()));
      return [];
    }
  }

  Future<List<ProductItem>> getSelectCategory(
      {required String categoryName}) async {
    emit(ProductsLoading());
    try {
      https.Response response = await https.get(Uri.parse(
          "https://fakestoreapi.com/products/category/$categoryName"));
      if (response.statusCode == 200) {
        List<ProductItem> selectedCategories =
            (jsonDecode(response.body) as List?)
                    ?.map((e) => ProductItem.fromJson(e))
                    .toList() ??
                [];
        emit(ProductsSuccess(products: selectedCategories));
        return selectedCategories;
      } else {
        emit(ProductsError(error: 'error'));
        throw Exception();
      }
    } catch (e) {
      emit(ProductsError(error: e.toString()));
      throw Exception(e);
    }
  }

  Future getProductsFromStorage() async {
    storageProducts = await LocalDataBase.getAllProducts();
  }
}
