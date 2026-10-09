class TransferAccountModel {
  int? id;
  String? name;
  String? accountNumber;
  String? dailyLimit;
  int? isActive;
  int? operatorId;
  String? operatorName;
  String? createdAt;
  String? updatedAt;

  TransferAccountModel({
    this.id,
    this.name,
    this.accountNumber,
    this.dailyLimit,
    this.isActive,
    this.operatorId,
    this.operatorName,
    this.createdAt,
    this.updatedAt,
  });

  TransferAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountNumber = json['account_number'];
    dailyLimit = json['daily_limit']?.toString();
    isActive = json['is_active'];
    operatorId = json['operator_id'];
    operatorName = json['operator_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account_number'] = accountNumber;
    data['daily_limit'] = dailyLimit;
    data['is_active'] = isActive;
    data['operator_id'] = operatorId;
    data['operator_name'] = operatorName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
