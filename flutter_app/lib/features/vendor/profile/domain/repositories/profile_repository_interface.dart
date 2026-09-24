import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_body.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_info.dart';
import 'package:multishop_tchad/features/vendor/interface/repository_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getSellerInfo();
  Future<http.StreamedResponse> updateProfile(ProfileInfoModel userInfoModel, ProfileBody seller,  File? file, String token, String password);
  Future<ApiResponse> deleteUserAccount();
}
