import 'package:flutter_sixvalley_ecommerce/core/models/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/models/commission_pay_request_model.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class TransactionRepositoryInterface implements RepositoryInterface {
  Future<ApiResponseModel> getWithdrawMethodList();

  Future<ApiResponseModel> payCommission({required CommissionPayRequestModel commissionPayRequest});

  Future<ApiResponseModel> storeOrUpdateWithdraw({
    required int auctionProductId,
    required int withdrawMethodId,
    int? existingWithdrawId,
    double? amount,
    Map<String, dynamic>? methodInfo,
    String? transactionNote,
    String? currentCurrencyCode,
  });
}
