import 'package:demoflutter/page/home.dart';
import 'package:demoflutter/page/user_list.dart';
import 'package:demoflutter/page/product_list.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(chooseWidget(window.defaultRouteName));

Widget chooseWidget(String routeName) {
  print(routeName);
  switch (routeName) {
    case 'demo':
      var view = MyFlutterView(HomePage());
      return view;
    case 'product_list':
      var view = MyFlutterView(ProductList());
      return view;
    case 'user_list':
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


