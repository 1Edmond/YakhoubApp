import 'package:multishop_tchad/features/vault/contact_us/domain/models/contact_us_body.dart';

abstract class ContactUsServiceInterface{

  Future<dynamic> add(ContactUsBody contactUsBody);
}
