import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:dio_custom/app/shared/constants.dart';
import 'package:dio_custom/app/shared/custom_dio/interceptors.dart';

class AuthRepository extends Disposable {
  Dio _client;

  AuthRepository() {
    // Usou-se uma nova instância do Dio porque a instância do CustomDio está travada aguardando o login
    _client = Dio();
    _client.options.baseUrl = BASE_URL;
    _client.interceptors.add(CustomInterceptors());
  }

  Future<Map> login(Map<String, dynamic> data) async {
    try {
      Response response = await _client.post("/sign_in", data: data);
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
