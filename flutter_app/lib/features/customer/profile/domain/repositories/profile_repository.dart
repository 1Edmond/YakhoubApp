import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/profile/domain/models/profile_model.dart';
import 'package:multishop_tchad/features/customer/profile/domain/repositories/profile_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepository implements ProfileRepositoryInterface{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ProfileRepository({required this.dioClient, required this.sharedPreferences});



  @override
  Future<ApiResponseModel> getProfileInfo() async {
    try {
      final response = await dioClient!.get(AppConstants.customerUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponseModel> delete(int customerId) async {
    try {
      final response = await dioClient!.get('${AppConstants.deleteCustomerAccount}/$customerId');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }




  @override
  Future<http.StreamedResponse> updateProfile(ProfileModel userInfoModel, String pass, File? file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.updateProfileUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(file != null){
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
     Map<String, String> fields = {};
    if(pass.isEmpty) {
      fields.addAll(<String, String>{
        '_method': 'put', 'f_name': userInfoModel.fName!, 'l_name': userInfoModel.lName!, 'phone': userInfoModel.phone!, 'email': userInfoModel.email!
      });
    }else {
      fields.addAll(<String, String>{
        '_method': 'put', 'f_name': userInfoModel.fName!, 'l_name': userInfoModel.lName!, 'phone': userInfoModel.phone!, 'password': pass, 'email': userInfoModel.email!
      });
    }
    request.fields.addAll(fields);
    if (kDebugMode) {
      print('========>${fields.toString()}');
    }
    http.StreamedResponse response = await request.send();
    return response;
  }

  @override
  Future add(value) {
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
