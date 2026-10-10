/// Compte de transfert (Airtel / Moov) proposé au client.
/// Contrat : GET /api/v1/transfer-accounts/available?amount=XXXX -> { accounts: [ ... ], transfer_fee }
class TransferAccountOption {
  final int id;
  final String operatorName;
  final String accountName;
  final String accountNumber;
  final double transferFee;
  final double remainingDaily;
  final String? operatorLogo;

  const TransferAccountOption({
    required this.id,
    required this.operatorName,
    required this.accountName,
    required this.accountNumber,
    required this.transferFee,
    required this.remainingDaily,
    this.operatorLogo,
  });

  factory TransferAccountOption.fromJson(Map<String, dynamic> json) {
    double d(dynamic v) => double.tryParse('${v ?? 0}') ?? 0.0;
    return TransferAccountOption(
      id: int.tryParse('${json['id']}') ?? 0,
      operatorName: '${json['bank_name'] ?? ''}',
      accountName: '${json['account_name'] ?? ''}',
      accountNumber: '${json['account_number'] ?? ''}',
      transferFee: d(json['transfer_fee']),
      remainingDaily: d(json['remaining_daily']),
      operatorLogo: json['operator_logo']?.toString(),
    );
  }
}
