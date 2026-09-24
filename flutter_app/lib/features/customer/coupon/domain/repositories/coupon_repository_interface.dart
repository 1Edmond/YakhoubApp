import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class CouponRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> getAvailableCouponList();

  Future<dynamic> getSellerCouponList(String slug, int offset);

}
