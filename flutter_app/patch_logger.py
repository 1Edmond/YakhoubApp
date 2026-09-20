import re

with open('lib/core/di/datasource/remote/dio/logging_interceptor.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('''  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print("ERROR[\] => PATH: \");
    }''',
'''  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print("ERROR[\] => PATH: \");
      print("ERROR MESSAGE: \");
      print("ERROR TYPE: \");
      print("ERROR ERROR: \");
    }''')

with open('lib/core/di/datasource/remote/dio/logging_interceptor.dart', 'w', encoding='utf-8') as f:
    f.write(content)
