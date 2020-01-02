import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    //200
    //201
    print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    //Exception (qualquer outro código além do 200 e 201)
    print("ERROR[${err.response.statusCode}] => PATH: ${err.request.path}");
    return super.onError(err);
  }
}
