import 'package:multishop_tchad/core/interfaces/repo_interface.dart';

abstract class ReOrderRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> reorder(String orderId);


}
