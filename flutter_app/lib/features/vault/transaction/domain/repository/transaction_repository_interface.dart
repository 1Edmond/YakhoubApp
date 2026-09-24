import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/transaction/domain/models/commission_pay_request_model.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

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
