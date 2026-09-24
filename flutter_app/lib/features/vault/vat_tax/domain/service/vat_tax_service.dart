import 'package:multishop_tchad/features/vault/vat_tax/domain/repository/vat_tax_repository_interface.dart';
import 'package:multishop_tchad/features/vault/vat_tax/domain/service/vat_tax_service_interface.dart';

class VatTaxService implements VatTaxServiceInterface {
  final VatTaxRepositoryInterface repositoryInterface;

  VatTaxService({required this.repositoryInterface});

  @override
  Future getVatTaxList() async {
    return await repositoryInterface.getVatTaxList();
  }
}
