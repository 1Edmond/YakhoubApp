import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_checkout/domain/repositories/auction_checkout_repository_interface.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

class AuctionCheckoutRepository implements AuctionCheckoutRepositoryInterface {
  final DioClient? dioClient;
  AuctionCheckoutRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> claimAuction(Map<String, dynamic> data) async {
    try {
      final response = await dioClient!.post(
        AppConstants.auctionClaimUri,
        data: data,
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> offlinePaymentList() async {
    try {
      final response = await dioClient!.get('${AppConstants.offlinePaymentList}?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}&is_guest=${!Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()}');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
