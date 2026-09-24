import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class WalletRepositoryInterface<T> extends RepositoryInterface{

  // Future<dynamic> getWalletTransactionList(int offset, String types, String startDate, String endDate, String filterByType);

  Future<dynamic> addFundToWallet(String amount, String paymentMethod, {String? paymentPhone});

  Future<dynamic> getWalletBonusBannerList();

  @override
  Future<dynamic> getList({int? offset = 1, String? filterBy, DateTime? startDate, DateTime? endDate, List<String>? transactionTypes});
}
