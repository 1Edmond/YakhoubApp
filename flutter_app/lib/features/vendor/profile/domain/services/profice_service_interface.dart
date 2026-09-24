import 'dart:io';
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_body.dart';
import 'package:multishop_tchad/features/vendor/profile/domain/models/profile_info.dart';

abstract class ProfileServiceInterface {
  Future<dynamic> getSellerInfo();
  Future<dynamic> updateProfile(ProfileInfoModel userInfoModel, ProfileBody seller,  File? file, String token, String password);
  Future<dynamic> deleteUserAccount();
}
