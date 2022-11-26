// ignore_for_file: prefer_const_constructors
import 'package:commercial_app/data/db/cached_products.dart';
import 'package:commercial_app/data/db/local_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CustomCarts extends StatefulWidget {
  final VoidCallback isTap;
  final Image image;
  final String title;
  final String dialogText;
  final String rate;
  final String price;
  final int index;
  final VoidCallback deleteId;
  CustomCarts({
    super.key,
    required this.image,
    required this.title,
    required this.dialogText,
    required this.rate,
    required this.price,
    required this.isTap,
    required this.index,
    required this.deleteId,
  });

  @override
  State<CustomCarts> createState() => _CustomCartsState();
}

class _CustomCartsState extends State<CustomCarts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 80, height: 80, child: widget.image),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title.length < 25
                          ? widget.title
                          : "${widget.title.substring(0, 25)}...",
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () => {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                              border: Border.all(
                                                  width: 1, color: Colors.grey),
                                              color: Colors.white10,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            width: 70,
                                            height: 70,
                                            child: widget.image,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                widget.title.length < 25
                                                    ? widget.title
                                                    : "${widget.title.substring(0, 25)}...",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                widget.rate,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                widget.price,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 17),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.pop(context),
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 17),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black),
                                            child: GestureDetector(
                                              onTap: widget.deleteId,
                                              child: Text(
                                                "Yes, Remove",
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
                        )
                      },
                      child: Icon(
                        Icons.restore_from_trash,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Rate: ${widget.rate}"),
                    Icon(Icons.star, color: Colors.yellow)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(widget.price.toString()),
                    SizedBox(width: 130),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                        GestureDetector(
                          child: const Text(
                            "-",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "0",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "+",
                          style: TextStyle(fontSize: 18),
                        )
                      ]),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
