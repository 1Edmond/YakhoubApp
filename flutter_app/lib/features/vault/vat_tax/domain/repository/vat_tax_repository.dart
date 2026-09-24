import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/vault/vat_tax/domain/repository/vat_tax_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class VatTaxRepository implements VatTaxRepositoryInterface{
  final DioClient? dioClient;
  VatTaxRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> getVatTaxList() async {
    try {
      final response = await dioClient!.get(AppConstants.getTaxVatList);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<dynamic> add(value) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get(String id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getList({int? offset = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}
