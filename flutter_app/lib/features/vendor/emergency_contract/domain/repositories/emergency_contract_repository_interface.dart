import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class EmergencyContractRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> addNewEmergencyContact(String name, String phone,int? id, {bool isUpdate = false});
  Future<ApiResponse> statusOnOffEmergencyContact(int? id, int status);
  Future<ApiResponse> getEmergencyContactListSearch(String key);
}
