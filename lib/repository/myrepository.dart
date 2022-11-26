import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/models/user.dart';
import 'package:commercial_app/service/api_provider.dart';

class MyRepository {
  final ApiProvider apiProvider;
  MyRepository({required this.apiProvider});
  Future<List<ProductItem>> getAllProducts() => apiProvider.getProductsList();
  Future<List<ProductItem>> getLimitedProduct(int limitedCount) =>
      apiProvider.getLimitedProduct(limitedCount: limitedCount);
  Future<List<String>> getAllCategories() => apiProvider.getAllCategories();
  Future<List<ProductItem>> getSelectCategory(String categoryName) =>
      apiProvider.getSelectCategory(categoryName: categoryName);
  //Future<List<User>> getAllUsers() => apiProvider.getAllUsers();

  List<String> images = [
    "assets/images/elec.png",
    "assets/images/jewelery.png",
    "assets/images/mencloth.png",
    "assets/images/womcloth.png",
  ];
}
