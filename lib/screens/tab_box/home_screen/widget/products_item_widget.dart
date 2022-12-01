import 'package:commercial_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductsItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  List<ProductItem> data;
  int index;

  ProductsItemWidget({
    super.key,
    required this.onTap,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.grey,
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              data[index].image == ""
                  ? SizedBox()
                  : Image.network(
                      data[index].image,
                      width: 90,
                      height: 90,
                    ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  data[index].title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                "Add to cart",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
