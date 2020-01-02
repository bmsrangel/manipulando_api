import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio_custom/app/shared/models/post_model.dart';
import 'package:dio_custom/app/shared/repositories/api_repository.dart';
import 'package:rxdart/rxdart.dart';

class CreateBloc extends BlocBase {
  final ApiRepository repo;

  CreateBloc(this.repo);

  String title;
  String body;

  BehaviorSubject<PostModel> post$ = BehaviorSubject<PostModel>();
  Sink<PostModel> get postIn => post$.sink;
  Stream<int> get responseOut => post$.switchMap(observablePost);

  Stream<int> observablePost(PostModel data) async* {
    yield 0;
    try {
      int response = await repo.createPost(data.toJson());
      yield response;
    } catch (e) {
      post$.addError(e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    post$.close();
    super.dispose();
  }
}
