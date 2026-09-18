import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/models/contact_us_body.dart';
import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class ContactUsRepositoryInterface {

  Future<dynamic> add(ContactUsBody contactUsBody);
}
