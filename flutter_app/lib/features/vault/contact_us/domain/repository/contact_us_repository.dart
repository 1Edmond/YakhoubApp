import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/contact_us/domain/models/contact_us_body.dart';
import 'package:multishop_tchad/features/vault/contact_us/domain/repository/contact_us_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class ContactUsRepository implements ContactUsRepositoryInterface{
  final DioClient? dioClient;
  ContactUsRepository({this.dioClient});

  @override
  Future<ApiResponseModel> add(ContactUsBody contactUsBody) async {
    try {
      final response = await dioClient!.post(AppConstants.contactUsUri,
          data: {
            "name" :contactUsBody.name,
            "email" : contactUsBody.email,
            "mobile_number" : contactUsBody.phone,
            "subject" : contactUsBody.subject,
            "message" : contactUsBody.message
          });
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
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
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }

}
