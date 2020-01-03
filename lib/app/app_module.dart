import 'package:dio_custom/app/shared/auth/auth_bloc.dart';
import 'package:dio_custom/app/shared/auth/auth_repository.dart';
import 'package:dio_custom/app/shared/repositories/api_repository.dart';
import 'package:dio_custom/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/shared/custom_dio/custom_dio_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio_custom/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AuthBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => AuthRepository()),
        Dependency((i) =>
            ApiRepository(kIsWeb ? i.get<CustomDioWeb>() : i.get<CustomDio>())),
        Dependency((i) => CustomDio()),
        Dependency((i) => CustomDioWeb())
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
