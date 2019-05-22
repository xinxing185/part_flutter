import 'package:demoflutter/page/home.dart';
import 'package:demoflutter/page/userlist.dart';
import 'package:demoflutter/page/productlist.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(chooseWidget(window.defaultRouteName));

Widget chooseWidget(String routeName) {
  print(routeName);
  switch (routeName) {
    case 'r1':
      var view = MyFlutterView(ProductList());
      return view;
    case 'product_list':
      var view = MyFlutterView(UserList());
      return view;
    default:
      return
        new Center(
          child: Text('Unkown Route'),
        );
  }
}

class MyFlutterView extends StatelessWidget {
  Widget homePage;

  MyFlutterView(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),

        home: homePage
    );
  }
}


