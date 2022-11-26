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
//  Container(
//                       padding: EdgeInsets.all(15),
//                       margin:
//                           EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       width: double.infinity,
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 80,
//                             height: 80,
//                             child: Image.network(
//                               CartPage.data[index].image,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     CartPage.data[index].title.length < 25
//                                         ? CartPage.data[index].title
//                                         : "${CartPage.data[index].title.substring(0, 25)}...",
//                                   ),
//                                   GestureDetector(
//                                       onTap: () => {
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) =>
//                                                   AlertDialog(
//                                                 title:
//                                                     Text("Remove From Cart?"),
//                                                 content: ,
//                                               ),
//                                             )
//                                           },
//                                       child: Icon(Icons.restore_from_trash))
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   Text(
//                                       "Rate: ${CartPage.data[index].ratingItem.rate}"),
//                                   Icon(Icons.star, color: Colors.yellow)
//                                 ],
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   Text(CartPage.data[index].price.toString()),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 5),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey.shade300,
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Row(children: [
//                                       Text(
//                                         "-",
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         "0",
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         "+",
//                                         style: TextStyle(fontSize: 18),
//                                       )
//                                     ]),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       )),
//                 ),
//               )
//             ],
//           )), 