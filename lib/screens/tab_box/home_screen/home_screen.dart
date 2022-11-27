// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:commercial_app/cubits/get_all_categories/get_all_categories_cubit.dart';
import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/repository/myrepository.dart';
import 'package:commercial_app/screens/tab_box/home_screen/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = "electronics";
  bool visibility = true;
  int id = 0;
  int selected = -1;
  int isSelected = -1;
  late MyRepository myRepository;
  List<ProductItem> products = [];
  List<ProductItem> productsLimited = [];
  List<String> allCategories = [];
  List<ProductItem> selectedCategories = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    myRepository = MyRepository();
    products = await context.read<ProductsCubit>().getProductsList();
    allCategories =
        await context.read<GetAllCategoriesCubit>().getAllCategories();
    setState(() {});
  }

  void updateUi({required String categoryName}) async {
    selectedCategories = await context
        .read<ProductsCubit>()
        .getSelectCategory(categoryName: categoryName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.grey.shade100,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/avatar.png"),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Good Morning",
            style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 14),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "YorqinBek Yuldashev",
            style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 17),
          ),
        ]),
        actions: [
          InkWell(
            onTap: () => {},
            child: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.yellow,
              shadows: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 5),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
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
                  child: visibility == true
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
                    log(data.toString());
                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          data.length,
                          (int index) => GestureDetector(
                            onTap: () => {
                              selectedCategory = data[index],
                              setState(
                                () => {
                                  selected = index,
                                  updateUi(
                                    categoryName: selectedCategory,
                                  )
                                },
                              )
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: selected == index
                                            ? Colors.black
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 5,
                                              color: Colors.grey)
                                        ]),
                                    child: Image.asset(
                                      myRepository.images[index],
                                      width: 30,
                                      height: 30,
                                      color: selected != index
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    data[index],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetAllCategoriesLoading) {
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1, 1),
                                    blurRadius: 5,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    );
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
                      itemBuilder: (context, index) => Stack(children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 1),
                                    color: Colors.grey,
                                    blurRadius: 4)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                data[index].image,
                                width: 80,
                                height: 80,
                              ),
                              Text(data[index].title),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
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
                                    isSelected = index,
                                  },
                                );
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: isSelected == index
                                    ? Colors.red
                                    : Colors.grey,
                              )),
                        )
                      ]),
                    ),
                  );
                } else if (state is ProductsError) {
                  return Center(child: Text(state.error.toString()));
                } else if (state is ProductsLoading) {
                  return Expanded(
                    flex: 4,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .85,
                      ),
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                    ),
                  );
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
}
