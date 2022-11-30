// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/delete_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCartsItem extends StatefulWidget {
  final int index;
  final VoidCallback deleteId;
  int countSelect;
  final int id;
  CustomCartsItem({
    super.key,
    required this.index,
    required this.deleteId,
    required this.countSelect,
    required this.id,
  });

  @override
  State<CustomCartsItem> createState() => _CustomCartsItemState();
}

class _CustomCartsItemState extends State<CustomCartsItem> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProductsFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.network(
              context.read<ProductsCubit>().storageProducts[widget.index].image,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        context
                            .read<ProductsCubit>()
                            .storageProducts[widget.index]
                            .title,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        deleteBottomSheet(
                          context: context,
                          index: widget.index,
                          deleteId: widget.deleteId,
                        );
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                        "Rate: ${context.read<ProductsCubit>().storageProducts[widget.index].rate}"),
                    Icon(Icons.star, color: Colors.yellow)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                        "\$${context.read<ProductsCubit>().storageProducts[widget.index].price}"),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(children: [
                        TextButton(
                          onPressed: () async {
                            if (context
                                    .read<ProductsCubit>()
                                    .storageProducts[widget.index]
                                    .countSelect >
                                0) {
                              int c = context
                                  .read<ProductsCubit>()
                                  .storageProducts[widget.index]
                                  .countSelect;
                              await LocalDataBase.editProductCount(
                                count: c - 1,
                                id: widget.id,
                              );
                              await context
                                  .read<ProductsCubit>()
                                  .getProductsFromStorage();
                            }
                            setState(() {});
                          },
                          child: const Text(
                            "-",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          context
                              .read<ProductsCubit>()
                              .storageProducts[widget.index]
                              .countSelect
                              .toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () async {
                            if (context
                                    .read<ProductsCubit>()
                                    .storageProducts[widget.index]
                                    .countSelect <
                                context
                                    .read<ProductsCubit>()
                                    .storageProducts[widget.index]
                                    .count) {
                              int c = context
                                  .read<ProductsCubit>()
                                  .storageProducts[widget.index]
                                  .countSelect;
                              await LocalDataBase.editProductCount(
                                count: c + 1,
                                id: widget.id,
                              );
                              await context
                                  .read<ProductsCubit>()
                                  .getProductsFromStorage();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Mahsulot qolmadi!"),
                                ),
                              );
                            }
                            setState(() {});
                          },
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
