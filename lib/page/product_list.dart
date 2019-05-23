import 'dart:convert';

import 'package:demoflutter/bridge/native_method.dart';
import 'package:demoflutter/model/category.dart';
import 'package:demoflutter/model/product.dart';
import 'package:demoflutter/model/response.dart';
import 'package:demoflutter/net/api.dart';
import 'package:demoflutter/net/http_util.dart';
import 'package:demoflutter/request/get_category.dart';
import 'package:demoflutter/request/get_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<StatefulWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ProductItem> products;
  int pageIndex = 0;

  @override
  void initState() {
    _fetchProductData(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    var contentView;
    if (products == null || products.length == 0) {
      contentView = Center(
          child: CircularProgressIndicator()
      );
    } else {
      contentView = Container(
        child: ListView.builder(
            itemBuilder: (context, i) => _buildProductItem(context, i),
            itemCount: products.length,
          )
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: "back",
          onPressed: () => NativeMethod.finishActivity(),
        ),
        elevation: 0.5,
        toolbarOpacity: 1,
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text(
          "ProductList",
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal),
        ),
      ),
      body:
      Container(
          child: Container(
            child: contentView,
          )
      ),
    );
  }

  _buildProductItem(BuildContext context, int i) {
    var prdImage = Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Image.network(products[i].picture,
          width: 60,
          height: 60,)
    );
    var prdInfo = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${products[i].goods_name}",
          style: TextStyle(
            color: Color(0xFF536DFE),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),),
        Container(
          padding: EdgeInsets.only(top: 0),
          child: Text("${products[i].market_price}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              )),
        ),
      ],
    );
    var rowItem = Container(
      margin: EdgeInsets.only(top: i == 0 ? 10 : 0, bottom: i == products.length -1 ? 10 : 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              prdImage,
              Expanded(
                child: prdInfo,
              )
            ],
          ),
          if (i < products.length -1) Divider(color: Colors.indigoAccent)
        ],
      ),
    );
    return rowItem;
  }

  _onHttpError(DioError error) {
    _snakeBarTips(error.message);
  }

  _onCategorySuccess(Response res) {
    print(res.data);
    Map<String, dynamic> map = json.decode(res.data);
    ResponseBody2<Category> responseBody = ResponseBody2<Category>.fromJson(map);
    List<Category> list = responseBody.getList(Category());
    print(list.length);
    print(list[0].category_name);
  }

  _onProductSuccess(Response res) {
    Map<String, dynamic> map = json.decode(res.data);

    ResponseBody1<Product> responseBody = ResponseBody1<Product>.fromJson(map);
    Product productList = responseBody.getData(Product());
    print(productList.total_count);
    setState(() {
      products = productList.items;
    });
  }

  _fetchCategoryData() {
    var cReq = CategoryRequest(
        category_version: 1,
        parent_id: 0,
        is_tree: 1,
        is_children: 0
    );
    Future<Response> res = HttpUtil.post(
        Api.BASE_URL, cReq.toJson());
    res.then((onValue) =>
        _onCategorySuccess(onValue),
        onError: (e) => _onHttpError(e));
  }

  _fetchProductData(int pageIndex) {
    var pReq = GetProductRequest(
      category_id: 1,
      page: pageIndex,
      page_size: 10,
    );
    Future<Response> res = HttpUtil.post(
        Api.BASE_URL, pReq.toJson());
    res.then((onValue) =>
        _onProductSuccess(onValue),
    onError: (e) => _onHttpError(e));
  }

  _snakeBarTips(String msg) {
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 2), // 持续时间
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
