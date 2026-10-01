class AddressModel {
  int? id;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  bool? isBilling;
  String? guestId;
  String? email;
  String? quarter;
  String? street;
  String? deliveryDescription;
  String? doorPhotoUrl;
  String? doorLatitude;
  String? doorLongitude;
  String? nni;

  AddressModel(
      {this.id,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling,
        this.guestId,
        this.email,
        this.quarter,
        this.street,
        this.deliveryDescription,
        this.doorPhotoUrl,
        this.doorLatitude,
        this.doorLongitude,
        this.nni,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing']??false;
    email = json['email'];
    quarter = json['quarter'] ?? json['delivery_quarter'];
    street = json['street'] ?? json['delivery_street'];
    deliveryDescription = json['delivery_description'] ?? json['description'];
    doorPhotoUrl = json['door_photo_url'] ?? json['door_photo'];
    doorLatitude = json['door_latitude']?.toString();
    doorLongitude = json['door_longitude']?.toString();
    nni = json['nni'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    data['guest_id'] = guestId;
    data['email'] = email;
    if (quarter != null) data['delivery_quarter'] = quarter;
    if (street != null) data['delivery_street'] = street;
    if (deliveryDescription != null) data['delivery_description'] = deliveryDescription;
    if (doorPhotoUrl != null) data['door_photo_url'] = doorPhotoUrl;
    if (doorLatitude != null) data['door_latitude'] = doorLatitude;
    if (doorLongitude != null) data['door_longitude'] = doorLongitude;
    if (nni != null) data['nni'] = nni;
    return data;
  }
}
