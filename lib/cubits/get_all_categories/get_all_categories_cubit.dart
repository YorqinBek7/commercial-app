import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as https;
part 'get_all_categories_state.dart';

class GetAllCategoriesCubit extends Cubit<GetAllCategoriesState> {
  GetAllCategoriesCubit() : super(GetAllCategoriesInitial());
  int selected = -1;
  String selectedCategory = "";
  Future<List<String>> getAllCategories() async {
    emit(GetAllCategoriesLoading());
    try {
      https.Response response = await https
          .get(Uri.parse("https://fakestoreapi.com/products/categories"));
      if (response.statusCode == 200) {
        List<String> categories = (jsonDecode(response.body) as List?)
                ?.map((e) => e as String)
                .toList() ??
            [];
        emit(GetAllCategoriesSucces(allCategories: categories));
        return categories;
      } else {
        emit(GetAllCategoriesError(error: 'error'));
        return [];
      }
    } catch (e) {
      emit(GetAllCategoriesError(error: e.toString()));
      return [];
    }
  }
}
