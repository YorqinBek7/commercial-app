import 'package:commercial_app/cubits/products/products_cubit.dart';
import 'package:commercial_app/screens/tab_box/cart_screen/widget/bottom_sheet_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void deleteBottomSheet({
  required BuildContext context,
  required int index,
  required VoidCallback deleteId,
}) {
  showBottomSheet(
    context: context,
    builder: (BuildContext context) => SizedBox(
      height: 200.h,
      child: BottomSheet(
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey.shade200,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Remove From Cart?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.h),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.grey),
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 100.w,
                        height: 100.h,
                        child: Image.network(
                          context
                              .read<ProductsCubit>()
                              .storageProducts[index]
                              .image,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                context
                                    .read<ProductsCubit>()
                                    .storageProducts[index]
                                    .title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.sp),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "${tr("rate")}: ${context.read<ProductsCubit>().storageProducts[index].rate}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "\$${context.read<ProductsCubit>().storageProducts[index].price}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: BottomSheetButtons(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: tr("cancel"),
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: BottomSheetButtons(
                          onTap: deleteId,
                          text: tr("yes_remove"),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
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
