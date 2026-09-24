import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multishop_tchad/core/di/datasource/remote/dio/dio_client.dart';
import 'package:multishop_tchad/core/di/datasource/remote/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/product/domain/repositories/category_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';


class CategoryRepository implements CategoryRepositoryInterface{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  CategoryRepository({required this.sharedPreferences, required this.dioClient});

  @override
  Future<ApiResponse> getCategoryList(String languageCode) async {
    try {
      final response = await dioClient!.get(AppConstants.categoryUri,
        options: Options(headers: {AppConstants.langKey: languageCode}),
      );
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

