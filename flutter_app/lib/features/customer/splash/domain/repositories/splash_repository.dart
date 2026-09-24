import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/splash/domain/repositories/splash_repository_interface.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository implements SplashRepositoryInterface {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponseModel> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.configUri);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponseModel> getBusinessPages(String type) async {
    try {
      final response =
          await dioClient!.get(AppConstants.businessPagesUri + type);
      return ApiResponseModel.withSuccess(response);
    } catch (e) {
      return ApiResponseModel.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  void initSharedData() async {
    if (!sharedPreferences!.containsKey(AppConstants.intro)) {
      sharedPreferences!.setBool(AppConstants.intro, true);
    }
    if (!sharedPreferences!.containsKey(AppConstants.currency)) {
      sharedPreferences!.setString(AppConstants.currency, '');
    }
  }

  @override
  String getCurrency() {
    return sharedPreferences!.getString(AppConstants.currency) ?? '';
  }

  @override
  void setCurrency(String currencyCode) {
    sharedPreferences!.setString(AppConstants.currency, currencyCode);
  }

  @override
  void disableIntro() {
    sharedPreferences!.setBool(AppConstants.intro, false);
  }

  @override
  bool? showIntro() {
    return sharedPreferences!.getBool(AppConstants.intro);
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
