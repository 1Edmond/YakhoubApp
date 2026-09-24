import 'package:multishop_tchad/features/vault/contact_us/domain/models/contact_us_body.dart';
// import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ContactUsRepositoryInterface {

  Future<dynamic> add(ContactUsBody contactUsBody);
}
