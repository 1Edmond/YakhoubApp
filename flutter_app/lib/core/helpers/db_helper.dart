import 'package:multishop_tchad/core/di/local/cache_response.dart';
import 'package:multishop_tchad/main.dart';

class DbHelper{
  static Future<void> insertOrUpdate({required String id, required CacheResponseCompanion data}) async {
    await database.insertCacheResponse(data);
  }


}
