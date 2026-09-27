import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/models/api_response.dart';
import 'package:multishop_tchad/core/widgets/base/custom_snackbar_widget.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/models/price_reduction_model.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/repositories/price_reduction_repository.dart';

class PriceReductionController extends ChangeNotifier {
  final PriceReductionRepository priceReductionRepository;
  PriceReductionController({required this.priceReductionRepository});

  final List<int> _tiers = [250, 500, 1000, 1500, 2000, 2500, 3000, 3500];
  List<int> get tiers => _tiers;

  int? _selectedTier;
  int? get selectedTier => _selectedTier;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Map<int, PriceReductionModel> _orderReductions = {};
  Map<int, PriceReductionModel> get orderReductions => _orderReductions;

  void selectTier(int tier) {
    _selectedTier = tier;
    notifyListeners();
  }

  void resetSelection() {
    _selectedTier = null;
    notifyListeners();
  }

  Future<void> fetchMyRequests() async {
    ApiResponseModel response = await priceReductionRepository.getMyReductionRequests();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data is List) {
        for (var item in response.response!.data) {
          final model = PriceReductionModel.fromJson(item);
          if (model.orderId != null) {
            _orderReductions[model.orderId!] = model;
          }
        }
      }
      notifyListeners();
    }
  }

  PriceReductionModel? getReductionForOrder(int orderId) {
    return _orderReductions[orderId];
  }

  Future<bool> sendReductionRequest({
    required int orderId,
    required double requestedReduction,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    ApiResponseModel response = await priceReductionRepository.requestReduction(orderId, requestedReduction);
    _isLoading = false;
    notifyListeners();

    if (response.response != null && (response.response!.statusCode == 200 || response.response!.statusCode == 201)) {
      final model = PriceReductionModel.fromJson(response.response!.data);
      _orderReductions[orderId] = model;
      showCustomSnackBarWidget('Demande de réduction envoyée avec succès', context, isError: false);
      notifyListeners();
      return true;
    } else {
      String errorMessage = response.error is String ? response.error : 'Échec de la demande';
      showCustomSnackBarWidget(errorMessage, context, isError: true);
      return false;
    }
  }

  Future<bool> respondToCounterOffer({
    required int requestId,
    required int orderId,
    required bool accept,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    ApiResponseModel response = await priceReductionRepository.respondToCounterOffer(requestId, accept);
    _isLoading = false;
    notifyListeners();

    if (response.response != null && response.response!.statusCode == 200) {
      if (_orderReductions.containsKey(orderId)) {
        _orderReductions[orderId]!.status = accept ? 'accepted' : 'refused';
      }
      showCustomSnackBarWidget(
        accept ? 'Contre-offre acceptée avec succès' : 'Contre-offre refusée',
        context,
        isError: false,
      );
      notifyListeners();
      return true;
    } else {
      String errorMessage = response.error is String ? response.error : 'Une erreur est survenue';
      showCustomSnackBarWidget(errorMessage, context, isError: true);
      return false;
    }
  }
}
