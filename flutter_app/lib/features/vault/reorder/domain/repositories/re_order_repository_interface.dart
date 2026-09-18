import 'package:flutter_sixvalley_ecommerce/core/interfaces/repo_interface.dart';

abstract class ReOrderRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> reorder(String orderId);


}
