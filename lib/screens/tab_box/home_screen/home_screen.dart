// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/repository/myrepository.dart';
import 'package:commercial_app/screens/tab_box/home_screen/category_item_widget.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/category_shimmer.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/custom_app_bar.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/products_item_widget.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/products_shimmer.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool visibility = true;
  int id = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 5),
        child: Column(
          children: [
            Visibility(
              visible: visibility,
              child: SearchField(
                  hintText: "Search",
                  prefixIcon: Icons.search,
                  suffixIcon: Icons.settings),
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
                    return Expanded(
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
                  List<ProductItem> data = state.products;
                  return Expanded(
                    flex: 4,
                    child: GridView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: .82),
                      itemBuilder: (context, index) => ProductsItemWidget(
                        onTap: () async {
                          var item = SelectedProducts(
                            count: data[index].ratingItem.count,
                            image: data[index].image,
                            price: data[index].price.toInt(),
                            rate: data[index].ratingItem.rate.toInt(),
                            title: data[index].title,
                            id: id++,
                          );
                          await LocalDataBase.insert(item);
                          setState(
                            () => {
                              context.read<ProductsCubit>().isSelected = index,
                            },
                          );
                        },
                        data: data,
                        index: index,
                        isSelected: context.read<ProductsCubit>().isSelected,
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
  }

  void updateUi({required String categoryName}) async {
    await context
        .read<ProductsCubit>()
        .getSelectCategory(categoryName: categoryName);
  }
}
