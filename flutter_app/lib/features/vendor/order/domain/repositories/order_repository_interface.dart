
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/order_details/domain/models/order_list_filter_model.dart';
import 'package:multishop_tchad/features/vendor/interface/repository_interface.dart';

abstract class OrderRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getOrderList(int offset, String status, OrderListFilterModel ? filter);
  Future<ApiResponse> orderAddressEdit({String? orderID, String? addressType, String? contactPersonName, String? phone, String? city, String? zip,
    String? address, String? email, String? latitude, String? longitude,
  });
}
