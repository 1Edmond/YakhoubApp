import 'package:multishop_tchad/core/models/response/base/api_response.dart';
// import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ShippingRepositoryInterface {
  Future<dynamic> add(dynamic value);
  Future<dynamic> delete(int id);
  Future<ApiResponse> getShipping();
  Future<ApiResponse> getShippingMethod(String token);
  Future<ApiResponse> updateShipping(String? title,String? duration,double? cost, int? id);
  Future<ApiResponse> getCategoryWiseShippingMethod();
  Future<ApiResponse> getSelectedShippingMethodType();
  Future<ApiResponse> setShippingMethodType( String? type);
  Future<ApiResponse> setCategoryWiseShippingCost(List<int? >  ids, List<double> cost, List<int> multiPly);
  Future<ApiResponse> shippingOnOff(int? id,int status);
}
