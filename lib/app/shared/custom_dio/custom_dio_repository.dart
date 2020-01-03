import 'package:dio/browser_imp.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_custom/app/shared/constants.dart';
import 'package:dio_custom/app/shared/custom_dio/auth_interceptor.dart';
import 'package:dio_custom/app/shared/custom_dio/interceptors.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = BASE_URL;
    interceptors.add(CustomInterceptors());
    interceptors.add(AuthInterceptor());
    options.connectTimeout = 5000;
  }
}

class CustomDioWeb extends DioForBrowser {
  CustomDioWeb() {
    options.baseUrl = BASE_URL;
    interceptors.add(CustomInterceptors());
    interceptors.add(AuthInterceptor());
    options.connectTimeout = 5000;
  }
}
