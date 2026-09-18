abstract class RepositoryInterface {
  Future<dynamic> add(Map<String, dynamic> body);
  Future<dynamic> update(Map<String, dynamic> body, int id);
  Future<dynamic> getList({int? offset});
  Future<dynamic> get(String id);
  Future<dynamic> delete(int id);
}
