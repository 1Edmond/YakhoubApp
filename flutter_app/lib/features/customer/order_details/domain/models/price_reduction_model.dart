class PriceReductionModel {
  int? id;
  int? orderId;
  int? customerId;
  int? vendorId;
  double? originalPrice;
  double? requestedReduction;
  double? proposedPrice;
  String? status; // 'pending', 'accepted', 'refused', 'counter_offer'
  double? counterOfferAmount;
  int? roundNumber;
  String? createdAt;
  String? updatedAt;

  PriceReductionModel({
    this.id,
    this.orderId,
    this.customerId,
    this.vendorId,
    this.originalPrice,
    this.requestedReduction,
    this.proposedPrice,
    this.status,
    this.counterOfferAmount,
    this.roundNumber,
    this.createdAt,
    this.updatedAt,
  });

  PriceReductionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    orderId = json['order_id'] is int ? json['order_id'] : int.tryParse(json['order_id']?.toString() ?? '');
    customerId = json['customer_id'] is int ? json['customer_id'] : int.tryParse(json['customer_id']?.toString() ?? '');
    vendorId = json['vendor_id'] is int ? json['vendor_id'] : int.tryParse(json['vendor_id']?.toString() ?? '');
    originalPrice = json['original_price'] != null ? double.tryParse(json['original_price'].toString()) : null;
    requestedReduction = json['requested_reduction'] != null ? double.tryParse(json['requested_reduction'].toString()) : null;
    proposedPrice = json['proposed_price'] != null ? double.tryParse(json['proposed_price'].toString()) : null;
    status = json['status']?.toString();
    counterOfferAmount = json['counter_offer_amount'] != null ? double.tryParse(json['counter_offer_amount'].toString()) : null;
    roundNumber = json['round_number'] is int ? json['round_number'] : int.tryParse(json['round_number']?.toString() ?? '1');
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['customer_id'] = customerId;
    data['vendor_id'] = vendorId;
    data['original_price'] = originalPrice;
    data['requested_reduction'] = requestedReduction;
    data['proposed_price'] = proposedPrice;
    data['status'] = status;
    data['counter_offer_amount'] = counterOfferAmount;
    data['round_number'] = roundNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
