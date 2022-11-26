// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:commercial_app/models/user.dart';
import 'package:commercial_app/repository/myrepository.dart';
import 'package:commercial_app/service/api_provider.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> user = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: ApiProvider.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(data[index].name.firstname),
                          subtitle: Text(data[index].name.lastname),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
