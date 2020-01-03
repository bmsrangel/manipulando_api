import 'package:dio/dio.dart';
import 'package:dio_custom/app/app_module.dart';
import 'package:dio_custom/app/shared/auth/auth_bloc.dart';
import 'package:dio_custom/app/shared/custom_dio/custom_dio_repository.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    AuthBloc auth = AppModule.to.bloc<AuthBloc>();
    final dio = kIsWeb
        ? AppModule.to.get<CustomDioWeb>()
        : AppModule.to.get<CustomDio>();

    var jwt = auth.jwt;
    if (jwt == null) {
      dio.lock();
      jwt = await auth.login();
      options.headers.addAll({"Authorization": jwt});
      dio.unlock();
    } else {
      options.headers.addAll({"Authorization": jwt});
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) {
    if (error.response?.statusCode == 401) {
      AuthBloc auth = AppModule.to.bloc<AuthBloc>();
      final dio = kIsWeb
          ? AppModule.to.get<CustomDioWeb>()
          : AppModule.to.get<CustomDio>();
      RequestOptions options = error.response.request;
      if (auth.jwt != options.headers["Auhtorization"]) {
        options.headers["Authorization"] = auth.jwt;
        return dio.request(options.path, options: options);
      }
      dio.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();
      return auth.login().then((d) {
        options.headers["Authorization"] = d;
      });
    }
    return super.onError(error);
  }
}
