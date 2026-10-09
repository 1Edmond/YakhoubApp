import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/di/model/response/base/api_response.dart';
import 'package:multishop_tchad/core/helpers/api_checker.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/domain/models/transfer_account_model.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/domain/repositories/transfer_account_repository.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/domain/models/transfer_operator_model.dart';

class TransferAccountController extends ChangeNotifier {
  final TransferAccountRepository transferAccountRepository;

  TransferAccountController({required this.transferAccountRepository});

  List<TransferAccountModel>? _transferAccounts;
  List<TransferAccountModel>? get transferAccounts => _transferAccounts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getTransferAccounts() async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await transferAccountRepository.getTransferAccounts();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _transferAccounts = [];
      if (apiResponse.response!.data != null && apiResponse.response!.data is List) {
        apiResponse.response!.data.forEach((account) {
          _transferAccounts!.add(TransferAccountModel.fromJson(account));
        });
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<ApiResponse> addTransferAccount(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await transferAccountRepository.addTransferAccount(data);
    _isLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getTransferAccounts();
    }
    return apiResponse;
  }

  Future<ApiResponse> updateTransferAccount(int id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await transferAccountRepository.updateTransferAccount(id, data);
    _isLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getTransferAccounts();
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteTransferAccount(int id) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await transferAccountRepository.deleteTransferAccount(id);
    _isLoading = false;
    notifyListeners();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getTransferAccounts();
    }
    return apiResponse;
  }
  List<TransferOperatorModel>? _transferOperators;
  List<TransferOperatorModel>? get transferOperators => _transferOperators;

  Future<void> getTransferOperators() async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await transferAccountRepository.getTransferOperators();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _transferOperators = [];
      if (apiResponse.response!.data != null && apiResponse.response!.data is List) {
        apiResponse.response!.data.forEach((operator) {
          _transferOperators!.add(TransferOperatorModel.fromJson(operator));
        });
      }
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }
}
