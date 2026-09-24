import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/vat_management/domain/repositories/vat_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class VatRepository implements VatRepositoryInterface{
  final DioClient? dioClient;
  VatRepository({required this.dioClient});

  @override
  Future<ApiResponse> getVatReport(int? limit, int? offset, String? startDate, String? endDate) async {
    String url = '${AppConstants.getVatTaxReportList}?limit=$limit&offset=$offset';

    if (startDate != null && endDate != null && startDate != 'null' && endDate != 'null') {
      url += '&start_date=$startDate&end_date=$endDate';
    }

    try {
      final response = await dioClient!.get(url);
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
  Future getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
  
  
  
}
