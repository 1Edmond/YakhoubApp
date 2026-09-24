
abstract class WalletServiceInterface {

  // Future<dynamic> getWalletTransactionList(int offset, String types, String startDate, String endDate, String filterByType);

  Future<dynamic> addFundToWallet(String amount, String paymentMethod, {String? paymentPhone});

  Future<dynamic> getWalletBonusBannerList();

  Future<dynamic> getList({int? offset = 1, String? filterBy, DateTime? startDate, DateTime? endDate, List<String>? transactionTypes});


}
