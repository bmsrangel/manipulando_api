import 'package:dio/native_imp.dart';
import 'package:dio_custom/app/shared/constants.dart';
import 'package:dio_custom/app/shared/custom_dio/interceptors.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = BASE_URL;
    interceptors.add(CustomInterceptors());
    options.connectTimeout = 5000;
  }
}
