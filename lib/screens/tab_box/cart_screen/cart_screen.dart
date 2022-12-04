// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/carts_item.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/when_no_element.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await context.read<ProductsCubit>().getProductsFromStorage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProductsCubit>().getProductsFromStorage();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          title: Text(
            tr("my_cart"),
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        body: context.watch<ProductsCubit>().storageProducts.isEmpty
            ? WhenNoElement()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          context.read<ProductsCubit>().storageProducts.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CustomCartsItem(
                        index: index,
                        deleteId: () async {
                          Navigator.pop(context);
                          await LocalDataBase.deleteByID(
                            context
                                .read<ProductsCubit>()
                                .storageProducts[index]
                                .id,
                          );
                          await context
                              .read<ProductsCubit>()
                              .getProductsFromStorage();
                          setState(() {});
                        },
                        countSelect: context
                            .read<ProductsCubit>()
                            .storageProducts[index]
                            .countSelect,
                        id: context
                            .read<ProductsCubit>()
                            .storageProducts[index]
                            .id,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
