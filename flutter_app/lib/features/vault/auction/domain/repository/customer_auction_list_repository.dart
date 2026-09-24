import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction/domain/repository/customer_auction_list_repository_interface.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

class CustomerAuctionListRepository implements CustomerAuctionListRepositoryInterface {
  final DioClient? dioClient;

  CustomerAuctionListRepository({required this.dioClient});

  void _setRequestHeaders(String? token) {
    dioClient!.dio!.options.headers = {
      'Authorization':
      'Bearer ${token ?? Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}',
      'Content-Type': 'application/json',
    };
  }


  @override
  Future<ApiResponseModel> getCustomerAuctionList({
    required int limit,
    required int offset,
    String? status,
    String? auctionStatus,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'limit': limit,
        'offset': offset,
        'include_counts': true,
        if (auctionStatus != null) 'auction_status': auctionStatus,
      };

      final response = await dioClient!.get(
        AppConstants.customerMyBidList,
        queryParameters: queryParams,
      );

      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getCustomerSavedAuctionList({
    required int limit,
    required int offset,
  }) async {
    final String token = Provider.of<AuthController>(Get.context!, listen: false).getUserToken();
    _setRequestHeaders(token);

    try {
      final response = await dioClient!.get(
        '${AppConstants.baseUrl}${AppConstants.auctionSaveListUri}',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override Future add(value) => throw UnimplementedError();
  @override Future delete(int id) => throw UnimplementedError();
  @override Future get(String id) => throw UnimplementedError();
  @override Future getList({int? offset = 1}) => throw UnimplementedError();
  @override Future update(Map<String, dynamic> body, int id) => throw UnimplementedError();
}
