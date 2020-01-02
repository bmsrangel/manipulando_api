import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:dio_custom/app/modules/home/subpages/create/create_bloc.dart';
import 'package:dio_custom/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
  CreateBloc bloc;

  setUp(() {
    bloc = HomeModule.to.bloc<CreateBloc>();
  });

  group('CreateBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CreateBloc>());
    });
  });
}
