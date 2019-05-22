import 'package:demoflutter/bridge/native_method.dart';
import 'package:demoflutter/model/product.dart';
import 'package:demoflutter/model/response.dart';
import 'package:demoflutter/net/api.dart';
import 'package:demoflutter/net/http_util.dart';
import 'package:demoflutter/request/get_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProductList extends StatefulWidget {

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<StatefulWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ProductBean> products;

  @override
  void initState() {
    _fetchData();
    _fetchPostData();
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
//      contentView = ListView.builder(
//        itemBuilder: (context, i) => _buildProductItem(context, i),
//        itemCount: products.length,
//      );
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
          "标准AppBar",
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.normal),
        ),
      ),
      body:
      Container(
          child: Center(
            child: contentView,
          )
      ),
    );
  }

  _buildProductItem(BuildContext context, int i) {
    var prdImage = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: CircleAvatar(
        backgroundImage: NetworkImage(products[i].avatar),
        backgroundColor: Color(0xFF42A5F5),
        radius: 20,
      ),
    );
    var prdImage2 = Container(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
      child: CircleAvatar(
        radius: 22,
        child: ClipOval(
          child: SizedBox(
            child: Image.network(products[i].avatar,
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
    var prdInfo = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${products[i].first_name} ${products[i].last_name}",
          style: TextStyle(
            color: Color(0xFF536DFE),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),),
        Container(
          padding: EdgeInsets.only(top: 5),
          child: Text("E-mail: ${products[i].email}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              )),
        ),
      ],
    );
    var rowItem = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            prdImage,
            Expanded(
              child: prdInfo,
            )
          ],
        ),
        Divider(color: Colors.indigoAccent)
      ],
    );
    return rowItem;
  }

  _onHttpError(DioError error) {
    _snakeBarTips(error.message);
  }

  _onHttpSuccess(Response res) {
    var prds = ProductsBean
        .fromMap(res.data);
    _snakeBarTips("data success ${prds.total}");
    setState(() {
      products = prds.data;
    });
  }

  _onCategorySuccess(Response res) {
    print(res.data);
    Map<String, dynamic> map = json.decode(res.data);
    ResponseBody2 responseBody = ResponseBody2.fromJson(map);
    List list = responseBody.data;
    for(int i = 0; i < list.length; i++) {

    }
  }

  _fetchData() {
    Future<Response> res = HttpUtil.get(
        "https://reqres.in/api/users", {"page": 1, "per_page": 14});
    res.then((onValue) =>
        _onHttpSuccess(onValue),
    onError: (e) => _onHttpError(e));
  }

  _fetchPostData() {
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

  _snakeBarTips(String msg) {
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 2), // 持续时间
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
