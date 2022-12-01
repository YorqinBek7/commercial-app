// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:developer';
import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/repository/myrepository.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/category_item_widget.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/category_shimmer.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/custom_app_bar.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/products_item_widget.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/products_shimmer.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/search.dart';
import 'package:commercial_app/screens/user_screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool visibility = true;
  int id = 0;
  bool isSearching = false;
  List<Models> elements = [];
  Set<ProductItem> searchedProducts = {};
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserScreen(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: visibility,
              child: SearchField(
                onChanged: (value) {
                  (value as String).isEmpty
                      ? isSearching = false
                      : isSearching = true;
                  searchedProducts.clear();
                  for (var element
                      in context.read<ProductsCubit>().allProducts) {
                    if (element.title.toLowerCase().trim().contains(value)) {
                      searchedProducts.add(element);
                    }
                  }
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special Offers",
                  style:
                      TextStyle(color: Colors.blueGrey.shade900, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => {
                    setState(
                      () => {
                        visibility = !visibility,
                      },
                    )
                  },
                  child: visibility
                      ? Text(
                          "Hide categories and search",
                          style: TextStyle(
                              color: Colors.blueGrey.shade900, fontSize: 16),
                        )
                      : Text(
                          "Back",
                          style: TextStyle(
                              color: Colors.blueGrey.shade900, fontSize: 16),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // <<------------------------------------------------- Get Categories Rows --------------------------------------------->>
            Visibility(
              visible: visibility,
              child: BlocBuilder<GetAllCategoriesCubit, GetAllCategoriesState>(
                builder: (context, state) {
                  if (state is GetAllCategoriesSucces) {
                    List<String> data = state.allCategories;
                    return SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          data.length,
                          (int index) => CategoryItemWidget(
                            selected:
                                context.read<GetAllCategoriesCubit>().selected,
                            myRepository: MyRepository(),
                            data: data,
                            index: index,
                            onTap: () => {
                              context
                                  .read<GetAllCategoriesCubit>()
                                  .selectedCategory = data[index],
                              setState(
                                () => {
                                  context
                                      .read<GetAllCategoriesCubit>()
                                      .selected = index,
                                  updateUi(
                                    categoryName: context
                                        .read<GetAllCategoriesCubit>()
                                        .selectedCategory,
                                  )
                                },
                              )
                            },
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetAllCategoriesLoading) {
                    return CategoryShimmer();
                  } else if (state is GetAllCategoriesError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            // <<--------------------------------------------------- Get Products ----------------------------------------->>
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsSuccess) {
                  List<ProductItem> data =
                      isSearching ? searchedProducts.toList() : state.products;
                  return Expanded(
                    flex: 4,
                    child: GridView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .82,
                      ),
                      itemBuilder: (context, index) => ProductsItemWidget(
                        onTap: () async {
                          var item = SelectedProducts(
                            count: data[index].ratingItem.count,
                            image: data[index].image,
                            price: data[index].price.toInt(),
                            rate: data[index].ratingItem.rate.toInt(),
                            title: data[index].title,
                            id: id++,
                            countSelect: 0,
                          );
                          await LocalDataBase.insert(item);
                          var s = await LocalDataBase.getAllProducts();
                          elements.add(
                            Models(
                              id: s.last.id,
                              index: index,
                            ),
                          );
                          final String encodedData = Models.encode(elements);
                          sharedPreferences.setString("models", encodedData);
                          setState(
                            () => {},
                          );
                        },
                        data: data,
                        index: index,
                        selectedElements: elements,
                      ),
                    ),
                  );
                } else if (state is ProductsError) {
                  return Center(child: Text(state.error.toString()));
                } else if (state is ProductsLoading) {
                  return ProductsShimmer();
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _init() async {
    context.read<ProductsCubit>().getProductsList();
    context.read<GetAllCategoriesCubit>().getAllCategories();
    context.read<ProductsCubit>().allProducts =
        await context.read<ProductsCubit>().getProductsList();
    sharedPreferences = await SharedPreferences.getInstance();
    final String? decodedData = sharedPreferences.getString("models");
    elements = Models.decode(decodedData!);
  }

  void updateUi({required String categoryName}) async {
    await context
        .read<ProductsCubit>()
        .getSelectCategory(categoryName: categoryName);
  }
}

class Models {
  int index;
  int id;
  Models({
    required this.id,
    required this.index,
  });

  factory Models.fromJson(Map<String, dynamic> json) {
    return Models(
      id: json["id"],
      index: json["index"],
    );
  }
  static Map<String, dynamic> toJson(Models models) {
    return {
      "id": models.id,
      "index": models.index,
    };
  }

  static String encode(List<Models> models) => json.encode(
        models
            .map(
              (e) => Models.toJson(e),
            )
            .toList(),
      );
  static List<Models> decode(String model) =>
      (json.decode(model) as List<dynamic>)
          .map((e) => Models.fromJson(e))
          .toList();
}
