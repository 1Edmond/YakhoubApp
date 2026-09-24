import 'dart:developer';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository_interface.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

class AuctionDashboardSummaryRepository implements AuctionDashboardSummaryRepositoryInterface {
  final DioClient? dioClient;
  AuctionDashboardSummaryRepository({required this.dioClient});

  void _setRequestHeaders(String? token) {
    final String? countryCode = dioClient!.countryCode;
    final String langValue =
        (countryCode == null || countryCode == 'US') ? 'en' : countryCode.toLowerCase();
    dioClient!.dio!.options.headers = {
      'Authorization': 'Bearer ${token ?? Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}',
      AppConstants.langKey: langValue,
    };
  }

  @override
  Future<ApiResponseModel> getAuctionDashboardSummary() async {
    final token = Provider.of<AuthController>(Get.context!, listen: false).getUserToken();
    _setRequestHeaders(token);
    try {
      final response = await dioClient!.get(AppConstants.auctionDashboardSummaryUri);
      log("DASHBOARD_RESPONSE: $response");
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
