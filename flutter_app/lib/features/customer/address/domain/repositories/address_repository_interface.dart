
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/models/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/models/label_model.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class AddressRepoInterface<T> {

  List<LabelAsModel> getAddressType();

  Future<dynamic> getDeliveryRestrictedCountryList();

  Future<dynamic> getDeliveryRestrictedZipList();

  Future<dynamic> getDeliveryRestrictedZipBySearch(String zipcode);

  Future<dynamic> getDeliveryRestrictedCountryBySearch(String country);


  Future<dynamic> getList({int? offset = 1});
  Future<dynamic> add(AddressModel addressModel);
  Future<dynamic> update(Map<String, dynamic> body, int id);
  Future<dynamic> delete(int id);
}
