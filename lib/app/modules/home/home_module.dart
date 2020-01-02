import 'package:dio_custom/app/modules/home/subpages/create/create_bloc.dart';
import 'package:dio_custom/app/app_module.dart';
import 'package:dio_custom/app/modules/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/shared/custom_dio/custom_dio_repository.dart';
import 'package:dio_custom/app/shared/repositories/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio_custom/app/modules/home/home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CreateBloc(i.get<ApiRepository>()), singleton: false),
        Bloc((i) => HomeBloc(i.get<ApiRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => ApiRepository(AppModule.to.get<CustomDio>())),
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
