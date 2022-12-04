import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteBottomSheet({
  required BuildContext context,
  required int index,
  required VoidCallback deleteId,
}) {
  showBottomSheet(
    context: context,
    builder: (BuildContext context) => SizedBox(
      height: 270,
      child: BottomSheet(
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey.shade200,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Remove From Cart?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 70,
                      height: 70,
                      child: Image.network(
                        context
                            .read<ProductsCubit>()
                            .storageProducts[index]
                            .image,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          context
                                      .read<ProductsCubit>()
                                      .storageProducts[index]
                                      .title
                                      .length <
                                  25
                              ? context
                                  .read<ProductsCubit>()
                                  .storageProducts[index]
                                  .title
                              : "${context.read<ProductsCubit>().storageProducts[index].title.substring(0, 25)}...",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          context
                              .read<ProductsCubit>()
                              .storageProducts[index]
                              .rate
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          context
                              .read<ProductsCubit>()
                              .storageProducts[index]
                              .price
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tr("cancel"),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: deleteId,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        child: Text(
                          tr("yes_remove"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    ),
  );
}
