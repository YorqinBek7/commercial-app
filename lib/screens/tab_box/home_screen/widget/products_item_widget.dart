import 'package:commercial_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductsItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  List<ProductItem> data;
  int index;
  int isSelected;
  ProductsItemWidget({
    super.key,
    required this.onTap,
    required this.data,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                blurRadius: 4,
              )
            ],
          ),
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
            onTap: onTap,
            child: Icon(
              Icons.favorite_border,
              color: isSelected == index ? Colors.red : Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
