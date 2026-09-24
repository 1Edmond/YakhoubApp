import 'package:multishop_tchad/features/shared/enums/data_source_enum.dart';
import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class BrandRepoInterface implements RepositoryInterface {
  Future<dynamic> getBrandList<T>({int offset, required DataSourceEnum source});

  Future<dynamic> getSellerWiseBrandList(String slug);
}
