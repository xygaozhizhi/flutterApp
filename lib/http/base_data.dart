import '../common/constant.dart';

class BaseData<T> {
  int code=1001;
  String message='';
  T? data;

  BaseData(this.code, this.message, this.data);

  BaseData.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    data = json[Constant.data];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[Constant.code] = code;
    data[Constant.message] = message;
    data[Constant.data] = data;
    return data;
  }
}
