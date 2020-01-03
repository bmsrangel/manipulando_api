import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:dio_custom/app/shared/auth/auth_bloc.dart';
import 'package:dio_custom/app/app_module.dart';

void main() {
  initModule(AppModule());
  AuthBloc bloc;

  setUp(() {
    bloc = AppModule.to.bloc<AuthBloc>();
  });

  group('AuthBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AuthBloc>());
    });
  });
}
