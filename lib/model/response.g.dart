// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBody _$ResponseBodyFromJson(Map<String, dynamic> json) {
  return ResponseBody(
      json['code'] as String, json['msg'] as String, json['crypt'] as String,
      data: json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ResponseBodyToJson(ResponseBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'crypt': instance.crypt,
      'data': instance.data
    };

ResponseBody2 _$ResponseBody2FromJson(Map<String, dynamic> json) {
  return ResponseBody2(
      json['code'] as String, json['msg'] as String, json['crypt'] as String,
      data: json['data'] as List);
}

Map<String, dynamic> _$ResponseBody2ToJson(ResponseBody2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'crypt': instance.crypt,
      'data': instance.data
    };
