import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/shared/models/post_model.dart';
import 'package:dio_custom/app/shared/repositories/api_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final ApiRepository repo;

  HomeBloc(this.repo);

  BehaviorSubject<List<PostModel>> listPost$ =
      BehaviorSubject<List<PostModel>>();
  Sink<List<PostModel>> get responseIn => listPost$.sink;
  Stream<List<PostModel>> get responseOut => listPost$.stream;

  void getPosts() async {
    try {
      List<PostModel> res = await repo.getPosts();
      responseIn.add(res);
    } catch (e) {
      listPost$.addError(e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    listPost$.close();
    super.dispose();
  }
}
