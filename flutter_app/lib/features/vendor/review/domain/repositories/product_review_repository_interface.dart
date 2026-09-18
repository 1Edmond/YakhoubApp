

import 'package:flutter_sixvalley_ecommerce/core/models/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class ProductReviewRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> productReviewList();
  Future<ApiResponse> filterProductReviewList(int? productId, String? customerId, int status, String? from, String? to);
  Future<ApiResponse> searchProductReviewList(String search);
  Future<ApiResponse> reviewStatusOnOff(int? reviewId, int status);
  Future<ApiResponse> getProductWiseReviewList(int? productId,int offset);
  Future<ApiResponse> sendReviewReply(int? reviewId,String replyText);

}
