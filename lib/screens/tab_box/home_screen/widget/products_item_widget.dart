import 'dart:developer';

import 'package:commercial_app/data/db/local_database.dart';
import 'package:commercial_app/models/product.dart';
import 'package:commercial_app/screens/tab_box/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class ProductsItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  List<ProductItem> data;
  int index;

  List<Models> selectedElements;
  ProductsItemWidget({
    super.key,
    required this.onTap,
    required this.data,
    required this.index,
    required this.selectedElements,
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
              Icons.favorite,
              color: getSelected(context) == index ? Colors.red : Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  int getSelected(BuildContext context) {
    int k = 0;
    int value = -1;
    int value2 = -1;
    for (var i = 0; i < selectedElements.length; i++) {
      k = 0;
      for (var j = 0; j < selectedElements.length; j++) {
        if (selectedElements[i].index == selectedElements[j].index) {
          k++;
        }
        if (k > 1) {
          value = i;
          value2 = selectedElements[i].index;
        }
      }
    }
    for (var i = 0; i < selectedElements.length; i++) {
      if (value != -1) {
        deleteFromDatabase(id: selectedElements[i].id);
        selectedElements.removeAt(value);
        value = -1;
      }
    }
    for (var i = 0; i < selectedElements.length; i++) {
      if (selectedElements[i].index == value2) {
        selectedElements.removeAt(i);
      }
    }
    for (var element in selectedElements) {
      if (element.index == index) {
        return element.index;
      }
    }
    return -1;
  }

  deleteFromDatabase({required int id}) async {
    await LocalDataBase.deleteByID(id);
    log(id.toString());
    await LocalDataBase.deleteByID(id + 1);
    log((id + 1).toString());
  }
}
