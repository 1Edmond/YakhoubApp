class PriceReductionModel {
  int? id;
  int? orderId;
  int? cartId;
  int? productId;
  int? customerId;
  int? vendorId;
  double? originalPrice;
  double? requestedReduction;
  double? proposedPrice;
  String? status; // 'pending', 'accepted', 'refused', 'counter_offer'
  double? counterOfferAmount;
  int? roundNumber;
  int? get round => roundNumber;
  String? createdAt;
  String? updatedAt;

  // Enriched product & customer fields
  String? productName;
  String? productThumbnail;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  String? customerImage;

  PriceReductionModel({
    this.id,
    this.orderId,
    this.cartId,
    this.productId,
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
    this.productName,
    this.productThumbnail,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.customerImage,
  });

  PriceReductionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '');
    orderId = json['order_id'] is int ? json['order_id'] : int.tryParse(json['order_id']?.toString() ?? '');
    cartId = json['cart_id'] is int ? json['cart_id'] : int.tryParse(json['cart_id']?.toString() ?? '');
    productId = json['product_id'] is int ? json['product_id'] : int.tryParse(json['product_id']?.toString() ?? '');
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

    // Parse product details
    if (json['product'] != null && json['product'] is Map) {
      final p = json['product'];
      productName = p['name']?.toString();
      if (p['thumbnail_full_url'] != null && p['thumbnail_full_url'] is Map) {
        productThumbnail = p['thumbnail_full_url']['path']?.toString();
      } else if (p['thumbnail'] != null) {
        productThumbnail = p['thumbnail']?.toString();
      }
    }

    // Parse customer details
    if (json['customer'] != null && json['customer'] is Map) {
      final c = json['customer'];
      final fName = c['f_name']?.toString() ?? '';
      final lName = c['l_name']?.toString() ?? '';
      customerName = ('$fName $lName').trim();
      if (customerName!.isEmpty && c['name'] != null) {
        customerName = c['name']?.toString();
      }
      customerPhone = c['phone']?.toString();
      customerEmail = c['email']?.toString();
      if (c['image_full_url'] != null && c['image_full_url'] is Map) {
        customerImage = c['image_full_url']['path']?.toString();
      } else if (c['image'] != null) {
        customerImage = c['image']?.toString();
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['cart_id'] = cartId;
    data['product_id'] = productId;
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
