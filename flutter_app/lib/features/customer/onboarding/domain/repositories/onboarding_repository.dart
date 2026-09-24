import 'package:dio/dio.dart';
import 'package:multishop_tchad/core/di/data_sources/dio_client.dart';
import 'package:multishop_tchad/core/di/data_sources/exception/api_error_handler.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/features/customer/onboarding/domain/models/onboarding_model.dart';
import 'package:multishop_tchad/features/customer/onboarding/domain/repositories/onboarding_repository_interface.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/core/constants/images.dart';

class OnBoardingRepository implements OnBoardingRepositoryInterface{
  final DioClient? dioClient;
  OnBoardingRepository({required this.dioClient});

  @override
  Future<ApiResponseModel> getList({int? offset}) async {
    try {
      List<OnboardingModel> onBoardingList = [
        OnboardingModel(Images.onBoarding1,
          '${getTranslated('on_boarding_title_one', Get.context!)} ${AppConstants.appName}',
          getTranslated('on_boarding_description_one', Get.context!)),
        OnboardingModel(Images.onBoarding2,
          getTranslated('on_boarding_title_two', Get.context!),
          getTranslated('on_boarding_description_two', Get.context!)),
        OnboardingModel(Images.onBoarding3,
          getTranslated('on_boarding_title_three', Get.context!),
          getTranslated('on_boarding_description_three', Get.context!)),
      ];

      Response response = Response(requestOptions: RequestOptions(path: ''), data: onBoardingList,statusCode: 200);
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
