import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/widgets/base/custom_snackbar_widget.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/models/price_reduction_model.dart';
import 'package:multishop_tchad/features/vendor/order_details/domain/repositories/vendor_reduction_repository.dart';

class VendorReductionController extends ChangeNotifier {
  final VendorReductionRepository vendorReductionRepository;
  VendorReductionController({required this.vendorReductionRepository});

  final List<int> _tiers = [250, 500, 1000, 1500, 2000, 2500, 3000, 3500];
  List<int> get tiers => _tiers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Map<int, PriceReductionModel> _orderReductions = {};
  Map<int, PriceReductionModel> get orderReductions => _orderReductions;

  Future<void> fetchRequests() async {
    _isLoading = true;

    ApiResponseModel response = await vendorReductionRepository.getReductionRequests();
    _isLoading = false;

    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data is List) {
        for (var item in response.response!.data) {
          final model = PriceReductionModel.fromJson(item);
          if (model.orderId != null) {
            _orderReductions[model.orderId!] = model;
          }
        }
      }
    }
    notifyListeners();
  }

  PriceReductionModel? getReductionForOrder(int orderId) {
    return _orderReductions[orderId];
  }

  Future<bool> acceptReduction(int requestId, int orderId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    ApiResponseModel response = await vendorReductionRepository.acceptReduction(requestId);
    _isLoading = false;

    if (response.response != null && response.response!.statusCode == 200) {
      if (_orderReductions.containsKey(orderId)) {
        _orderReductions[orderId]!.status = 'accepted';
      }
      showCustomSnackBarWidget('Réduction acceptée avec succès', context, isError: false);
      notifyListeners();
      return true;
    } else {
      showCustomSnackBarWidget('Échec de la validation de la réduction', context, isError: true);
      notifyListeners();
      return false;
    }
  }

  Future<bool> refuseReduction(int requestId, int orderId, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    ApiResponseModel response = await vendorReductionRepository.refuseReduction(requestId);
    _isLoading = false;

    if (response.response != null && response.response!.statusCode == 200) {
      if (_orderReductions.containsKey(orderId)) {
        _orderReductions[orderId]!.status = 'refused';
      }
      showCustomSnackBarWidget('Réduction refusée', context, isError: false);
      notifyListeners();
      return true;
    } else {
      showCustomSnackBarWidget('Échec du refus', context, isError: true);
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendCounterOffer(int requestId, int orderId, double counterAmount, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    ApiResponseModel response = await vendorReductionRepository.counterOffer(requestId, counterAmount);
    _isLoading = false;

    if (response.response != null && response.response!.statusCode == 200) {
      if (_orderReductions.containsKey(orderId)) {
        _orderReductions[orderId]!.status = 'counter_offer';
        _orderReductions[orderId]!.counterOfferAmount = counterAmount;
      }
      showCustomSnackBarWidget('Contre-proposition envoyée au client', context, isError: false);
      notifyListeners();
      return true;
    } else {
      showCustomSnackBarWidget('Échec de l\'envoi de la contre-proposition', context, isError: true);
      notifyListeners();
      return false;
    }
  }
}
