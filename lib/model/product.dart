
class ProductsBean {
  /**
   * page : 1
   * per_page : 3
   * total : 12
   * total_pages : 4
   * data : [{"id":1,"email":"george.bluth@reqres.in","first_name":"George","last_name":"Bluth","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"},{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"},{"id":3,"email":"emma.wong@reqres.in","first_name":"Emma","last_name":"Wong","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg"}]
   */

  int page;
  int per_page;
  int total;
  int total_pages;
  List<ProductBean> data;

  static ProductsBean fromMap(Map<String, dynamic> map) {
    ProductsBean product = new ProductsBean();
    product.page = map['page'];
    product.per_page = map['per_page'];
    product.total = map['total'];
    product.total_pages = map['total_pages'];
    product.data = ProductBean.fromMapList(map['data']);
    return product;
  }

  static List<ProductsBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<ProductsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ProductBean {
  /**
   * email : "george.bluth@reqres.in"
   * first_name : "George"
   * last_name : "Bluth"
   * avatar : "https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"
   * id : 1
   */

  String email;
  String first_name;
  String last_name;
  String avatar;
  int id;

  static ProductBean fromMap(Map<String, dynamic> map) {
    ProductBean dataListBean = new ProductBean();
    dataListBean.email = map['email'];
    dataListBean.first_name = map['first_name'];
    dataListBean.last_name = map['last_name'];
    dataListBean.avatar = map['avatar'];
    dataListBean.id = map['id'];
    return dataListBean;
  }

  static List<ProductBean> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<ProductBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
