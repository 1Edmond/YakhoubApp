import 'dart:io';

import 'package:multishop_tchad/features/customer/profile/domain/models/profile_model.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getProfileInfo();
  Future<dynamic> updateProfile(ProfileModel userInfoModel, String pass, File? file, String token);
}
