import 'package:dio/dio.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/shared/notification/domain/repositories/notification_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class NotificationRepository implements NotificationRepositoryInterface{
  final DioClient? dioClient;
  NotificationRepository({required this.dioClient});

  @override
  Future<ApiResponseModel>  getList({int? offset}) async {
    try {
      Response response = await dioClient!.get('${AppConstants.notificationUri}?limit=10&guest_id=1&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel>  seenNotification(int id) async {
    try {
      Response response = await dioClient!.get('${AppConstants.seenNotificationUri}?id=$id&guest_id=1');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getAuctionList({int limit = 10, int offset = 1}) async {
    try {
      Response response = await dioClient!.get('${AppConstants.auctionNotificationListUri}?limit=$limit&offset=$offset');
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> markAuctionSeen({int? id}) async {
    try {
      final Map<String, dynamic> fields = {};
      if (id != null) fields['id'] = id;
      Response response = await dioClient!.post(AppConstants.auctionNotificationSeenUri, data: fields);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
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
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
