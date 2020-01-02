import 'package:dio_custom/app/shared/repositories/api_repository.dart';
import 'package:dio_custom/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/shared/custom_dio/custom_dio_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio_custom/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => ApiRepository(i.get<CustomDio>())),
        Dependency((i) => CustomDio()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}