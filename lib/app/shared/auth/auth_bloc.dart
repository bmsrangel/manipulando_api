import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/app_module.dart';
import 'package:dio_custom/app/shared/auth/auth_repository.dart';

class AuthBloc extends BlocBase {
  AuthRepository repo;
  String jwt;

  AuthBloc() {
    repo = AppModule.to.get<AuthRepository>();
  }

  Future<String> login() async {
    var res = await repo
        .login({"email": "flutter@gmail.com", "password": "123456789"});
    jwt = res["token"];
    return jwt;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
