import 'package:json_annotation/json_annotation.dart';

import 'base.dart';
part 'response.g.dart';

@JsonSerializable()
class ResponseBody extends Object {
  String code;
  String msg;
  String crypt;
  Map<String, dynamic> data;

  ResponseBody(this.code, this.msg, this.crypt, {this.data});

  factory ResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ResponseBodyFromJson(json);
}

@JsonSerializable()
class ResponseBody2<T extends BaseResponseData> extends Object {
  String code;
  String msg;
  String crypt;
  List data;

  ResponseBody2(this.code, this.msg, this.crypt, {this.data});

  factory ResponseBody2.fromJson(Map<String, dynamic> json) =>
      _$ResponseBody2FromJson(json);

  List<T> getList(T type) {
    List<T> listItems = List<T>(data.length);
    for(int i = 0; i < data.length; i++) {
      type.createSelf(data[i]);
      listItems.add(type.createSelf(data[i]));
    }
    return listItems;
  }
}