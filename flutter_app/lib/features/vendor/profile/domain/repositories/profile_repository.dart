import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_body.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_info.dart';
import 'package:multishop_tchad/features/vendor/profile/domain/repositories/profile_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class ProfileRepository implements ProfileRepositoryInterface{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ProfileRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> getSellerInfo() async {
    try {
      final response = await dioClient!.get(AppConstants.sellerUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<http.StreamedResponse> updateProfile(ProfileInfoModel userInfoModel, ProfileBody seller,  File? file, String token, String password) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.sellerAndBankUpdate}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    Map<String, String> fields = {};
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    fields.addAll(<String, String>{
      '_method': 'put', 'f_name': userInfoModel.fName!, 'l_name': userInfoModel.lName!, 'phone': userInfoModel.phone!,
    });
    if(password.isNotEmpty) {
      fields.addAll({'password': password});
    }
    if (kDebugMode) {
      print(fields.toString());
    }
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  @override
  Future<ApiResponse> deleteUserAccount() async {
    try {
      final response = await dioClient!.get(AppConstants.deleteAccount);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }



}
