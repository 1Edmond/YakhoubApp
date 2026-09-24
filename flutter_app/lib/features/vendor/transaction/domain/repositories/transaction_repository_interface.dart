

import 'package:multishop_tchad/core/models/response/base/api_response.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class TransactionRepositoryInterface implements RepositoryInterface{
  Future<ApiResponse> getTransactionList(String status, String from, String to);
  Future<ApiResponse> getMonthTypeList();
  Future<ApiResponse> getYearList();
}
