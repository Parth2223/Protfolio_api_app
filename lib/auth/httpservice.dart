import 'dart:convert';
import 'package:portfolioapps/model/albums_model.dart';
import 'package:portfolioapps/model/photos+model.dart';
import 'package:portfolioapps/model/post_models.dart';
import 'package:portfolioapps/model/todos_model.dart';
import 'package:portfolioapps/model/user_login_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  String baseurl = "https://jsonplaceholder.typicode.com/";

  Future<List<UserLoginModel>> getUserLogin() async {
    String uri = baseurl + "users/";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      List<UserLoginModel>? userlist = responseData != null
          ? (responseData as List)
              .map((i) => UserLoginModel.fromJson(i))
              .toList()
          : null;

      return userlist ?? [];
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<List<TodosModel>> getTodos() async {
    String uri = baseurl + "todos/";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final responsedata = jsonDecode(response.body);
      List<TodosModel>? todoslist = responsedata != null
          ? (responsedata as List).map((i) => TodosModel.fromJson(i)).toList()
          : null;
      return todoslist ?? [];
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<List<AlbumsModel>> getAlbums() async {
    String uri = baseurl + "albums/";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final responsedata = jsonDecode(response.body);
      List<AlbumsModel>? albumslist = responsedata != null
          ? (responsedata as List).map((e) => AlbumsModel.fromJson(e)).toList()
          : null;
      return albumslist ?? [];
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<List<PostModel>> getPost() async {
    String uri = baseurl + "posts/";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final responsedata = jsonDecode(response.body);
      List<PostModel>? postlist = responsedata != null
          ? (responsedata as List).map((e) => PostModel.fromJson(e)).toList()
          : null;
      return postlist ?? [];
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<List<PhotosModel>> getPhoto() async {
    String uri = baseurl + "photos/";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final responsedata = jsonDecode(response.body);
      List<PhotosModel>? photoslist = responsedata != null
          ? (responsedata as List).map((e) => PhotosModel.fromJson(e)).toList()
          : null;
      return photoslist ?? [];
    } else {
      throw Exception('Failed to load data from the server');
    }
  }
}
