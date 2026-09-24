import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/features/vendor/order_edit/domain/repositories/order_edit_repository_interface.dart';
import 'package:multishop_tchad/features/vendor/order_edit/domain/services/order_edit_service_interface.dart';

class OrderEditService implements OrderEditServiceInterface {
  final OrderEditRepositoryInterface orderEditRepositoryInterface;

  OrderEditService({required this.orderEditRepositoryInterface});

  @override
  Future getSellerProductList({
    required String sellerId,
    required int offset,
    required String languageCode,
    required String search,
    required String orderId
  }) {
    return orderEditRepositoryInterface.getSellerProductList(
      sellerId: sellerId,
      offset: offset,
      languageCode: languageCode,
      search: search,
      orderId: orderId
    );
  }

  @override
  Future editOrderSubmit({required Map<String, dynamic> data}) {
    return orderEditRepositoryInterface.editOrderSubmit(data);
  }


  @override
  Future<ApiResponse> switchToCod(int orderId) {
    return orderEditRepositoryInterface.switchToCod(orderId);
  }

  @override
  Future editOrderValidation({required Map<String, dynamic> data}) {
    return orderEditRepositoryInterface.editOrderValidation(data);
  }

}
