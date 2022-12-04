import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/delete_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(15.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            height: 80.h,
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        deleteBottomSheet(
                          context: context,
                          index: widget.index,
                          deleteId: widget.deleteId,
                        );
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.pinkAccent,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                        "${tr("rate")}: ${context.read<ProductsCubit>().storageProducts[widget.index].rate}"),
                    const Icon(Icons.star, color: Colors.yellow)
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                        "\$${context.read<ProductsCubit>().storageProducts[widget.index].price}"),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.r),
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
                          child: Text(
                            "-",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          context
                              .read<ProductsCubit>()
                              .storageProducts[widget.index]
                              .countSelect
                              .toString(),
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        SizedBox(width: 10.w),
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
                                  content: Text(tr("no_product")),
                                ),
                              );
                            }
                            setState(() {});
                          },
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 18.sp),
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
