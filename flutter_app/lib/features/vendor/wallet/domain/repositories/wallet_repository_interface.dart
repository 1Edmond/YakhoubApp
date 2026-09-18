

import 'package:flutter_sixvalley_ecommerce/core/models/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class WalletRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getDynamicWithDrawMethod();
  Future<ApiResponse> withdrawBalance(List <String?> typeKey, List<String> typeValue, int? id, String balance);
  Future<ApiResponse> getPaymentInfoList();
  Future<ApiResponse> closeWithdrawRequest(int? id, String balance);
  Future<ApiResponse> updateWithdrawRequest(List<String?> typeKey, List<String> typeValue, int? methodId, String balance, int requestId);

}
