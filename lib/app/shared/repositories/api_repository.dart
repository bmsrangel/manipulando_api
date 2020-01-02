import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:dio_custom/app/shared/custom_dio/custom_dio_repository.dart';
import 'package:dio_custom/app/shared/models/post_model.dart';

class ApiRepository extends Disposable {
  final _client;

  ApiRepository(this._client);

  Future<List<PostModel>> getPosts() async {
    try {
      Response response = await _client.get("/posts");
      return (response.data as List)
          .map((item) => PostModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<int> createPost(Map<String, dynamic> data) async {
    try {
      Response response = await _client.post("/posts", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<int> updatePost(Map<String, dynamic> data, int id) async {
    try {
      Response response = await _client.put("/posts/$id", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}

// CREATE -> POST
// READ -> GET
// UPDATE
// DELETE
