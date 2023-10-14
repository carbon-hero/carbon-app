import 'dart:io';

import 'package:flutter_lifestyle/networking/api_endpoints.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/networking/dio_client.dart';

class UserRepository {
  Future<ApiResponse?> getUser() async {
    return RestApiService().post(ApiEndpoints.user);
  }

  Future<ApiResponse?> saveUser(Map<String, dynamic> params) async {
    return RestApiService().post(ApiEndpoints.saveUser, data: params);
  }

  Future<ApiResponse?> getFile(String id) async {
    return RestApiService().get("${ApiEndpoints.getFile}$id");
  }

  Future<ApiResponse?> saveFile(String type, File file) async {
    return RestApiService()
        .postMultipart(ApiEndpoints.fileSave, type: type, file: file.path);
  }

  Future<ApiResponse?> getPoints() async {
    return RestApiService().get(ApiEndpoints.points);
  }

  Future<ApiResponse?> getTravelMode() async {
    return RestApiService().get(ApiEndpoints.travelMode);
  }

  Future<ApiResponse?> saveCommuteHistory(Map<String, dynamic> params) async {
    return RestApiService().post(ApiEndpoints.commuteHistory, data: params);
  }

  Future<ApiResponse?> addFriend(Map<String, dynamic> params) async {
    return RestApiService().post(ApiEndpoints.addFriend,data: params);
  }

  Future<ApiResponse?> getAllSetting() async {
    return RestApiService().get(ApiEndpoints.appSettings);
  }

}
