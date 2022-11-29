import 'package:commercial_app/repository/myrepository.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    required this.selected,
    required this.myRepository,
    required this.data,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int selected;
  final MyRepository myRepository;
  final List<String> data;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected == index ? Colors.black : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 1), blurRadius: 5, color: Colors.grey)
                  ]),
              child: Image.asset(
                myRepository.images[index],
                width: 30,
                height: 30,
                color: selected != index ? Colors.black : Colors.white,
              ),
            ),
            Text(
              data[index],
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.blueGrey.shade900,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
