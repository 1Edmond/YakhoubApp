

import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/settings/domain/models/business_model.dart';
import 'package:multishop_tchad/features/vendor/settings/domain/repositories/buisness_repository_interface.dart';
import 'package:multishop_tchad/features/vendor/settings/domain/services/business_service_interface.dart';
import 'package:multishop_tchad/core/helpers/api_checker.dart';

class BusinessService implements BusinessServiceInterface{
  final BusinessRepositoryInterface businessRepoInterface;
  BusinessService({required this.businessRepoInterface});

  @override
  Future getBusinessList() async{
    List<BusinessModel>? businessList;
    ApiResponse apiResponse = await businessRepoInterface.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      businessList = [];
      apiResponse.response!.data.forEach((business) => businessList!.add(business));
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    return businessList;
  }
}
