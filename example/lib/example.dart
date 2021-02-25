import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dart:io';
import 'package:http_parser/http_parser.dart' show MediaType;

part 'example.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/apiResponse')
  Future<ApiResponse<Task>> getResponse();

  @GET('/apiResponse')
  Future<ApiResponse<List<Task>>> getResponseList();

  @GET('/apiResponse')
  Future<ApiResponse> getResponseList();
}

@JsonSerializable()
class Task {
  String id;
  String name;
  String avatar;
  String createdAt;

  Task({this.id, this.name, this.avatar, this.createdAt});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

enum Status {
  @JsonValue("new")
  New,
  @JsonValue("on_going")
  OnGoing,
  @JsonValue("closed")
  Closed,
}

@JsonSerializable()
class TaskQuery {
  List<Status> statuses;

  TaskQuery(this.statuses);

  factory TaskQuery.fromJson(Map<String, dynamic> json) => _$TaskQueryFromJson(json);

  Map<String, dynamic> toJson() => _$TaskQueryToJson(this);
}

@JsonSerializable()
class TaskGroup {
  DateTime date;
  List<Task> todos;
  List<Task> completed;
  List<Task> inProgress;

  TaskGroup({this.date, this.todos, this.completed, this.inProgress});

  factory TaskGroup.fromJson(Map<String, dynamic> json) => _$TaskGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TaskGroupToJson(this);
}

class ApiResponse<T> {
  int code;
  String msg;
  T data;

  ApiResponse({this.code, this.msg, this.data});
}
