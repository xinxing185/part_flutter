import 'package:json_annotation/json_annotation.dart';
part 'base.g.dart';

@JsonSerializable()
class BaseRequest {
  String cmd;

  BaseRequest(this.cmd);

  Map<String, dynamic> toJson() {
    return null;
  }

}