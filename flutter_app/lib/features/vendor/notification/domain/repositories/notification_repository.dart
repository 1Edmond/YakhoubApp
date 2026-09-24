
import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/notification/domain/repositories/notification_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class NotificationRepository implements NotificationRepositoryInterface{
  final DioClient? dioClient;
  NotificationRepository({required this.dioClient});

  @override
  Future<ApiResponse> seenNotification(int id) async {
    try {
      final response = await dioClient!.get('${AppConstants.seenNotification}$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) async{
    try {
      final response = await dioClient!.get('${AppConstants.getNotificationList}$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> getAuctionNotificationList({int limit = 10, int offset = 1}) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.auctionNotificationList}?limit=$limit&offset=$offset',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> markAuctionNotificationSeen({int? id}) async {
    try {
      final response = await dioClient!.post(
        AppConstants.auctionMarkNotificationSeen,
        data: id != null ? {'id': id} : null,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
