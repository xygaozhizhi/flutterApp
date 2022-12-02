import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:myflutterapp/http/base_data.dart';
import 'error_handle.dart';

/// 连接超时时间
int _connectTimeout = 15000;

/// 响应超时时间
int _receiveTimeout = 15000;

/// 发送数据超时时间
int _sendTimeout = 10000;

///基类Url
String _baseUrl = '';

///拦截器
List<Interceptor> _interceptors = [];

/// 初始化Dio配置
void configDio({
  int? connectTimeout,
  int? receiveTimeout,
  int? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef HttpSuccessCallback<T> = Function(String data);
typedef HttpErrorCallback = Function(dynamic obj);
typedef HttpDoneCallback = Function();

class DioUtil {
  factory DioUtil() => _singleton;

  static final DioUtil _singleton = DioUtil._();

  static late Dio _dio;

  DioUtil._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,

      /// dio默认json解析，这里指定返回UTF8字符串，自己处理解析。（可也以自定义Transformer实现）
      responseType: ResponseType.json,
      validateStatus: (_) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: _baseUrl,
    );
    _dio = Dio(options);

    _interceptors.forEach(addInterceptor);
  }

  /// 添加拦截器
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// 数据返回格式统一，统一处理异常
  Future<BaseData<T>> _request<T>(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      cancelToken: cancelToken,
    );
    final Map<String, dynamic> map = json.decode(response.data.toString());
    return BaseData<T>.fromJson(map);
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  Future<dynamic> requestNetwork<T>(
    Method method,
    String url, {
    HttpSuccessCallback<T>? onSuccess,
    HttpErrorCallback? onError,
    HttpDoneCallback? onDone,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return _request<T>(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ).then((BaseData<T> result) {
      if (result.code == ExceptionHandle.success) {
        return Future.value(jsonEncode(result.data));
      } else {
        throw NetException(result.code, result.message);
      }
    }).catchError((e) =>
        throw (e is NetException) ? e : ExceptionHandle.handleException(e));
  }
}

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
