// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/carts.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CartPage extends StatefulWidget {
  static final List<ProductItem> data = [];

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<SelectedProducts> getAllProducts = [];
  @override
  initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    getAllProducts = await LocalDataBase.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        _init();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          title: Text(
            "My Cart",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: getAllProducts.length,
                  itemBuilder: (BuildContext context, int index) => CustomCarts(
                    image: Image.network(getAllProducts[index].image),
                    title: getAllProducts[index].title,
                    dialogText: "Remove From Cart?",
                    rate: getAllProducts[index].rate.toString(),
                    price: getAllProducts[index].price.toString(),
                    isTap: () {
                      setState(() {});
                    },
                    index: index,
                    deleteId: () async {
                      Navigator.pop(context);
                      await LocalDataBase.deleteByID(getAllProducts[index].id);
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
