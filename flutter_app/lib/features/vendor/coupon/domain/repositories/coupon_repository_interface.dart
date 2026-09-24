import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/coupon/domain/models/coupon_model.dart';

abstract class CouponRepositoryInterface {
  Future<ApiResponse> updateCouponStatus(int? id, int status);
  Future<ApiResponse> getCouponCustomerList(String search);
  Future<dynamic> add(Coupons value, {bool update = false});
  Future<dynamic> delete(int id);
  Future<dynamic> getList({int? offset = 1});
}
