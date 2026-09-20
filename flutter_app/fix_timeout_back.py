import re

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("..options.connectTimeout = const Duration(seconds: 300)", "..options.connectTimeout = const Duration(seconds: 60)")
content = content.replace("..options.receiveTimeout = const Duration(seconds: 300)", "..options.receiveTimeout = const Duration(seconds: 60)")

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'w', encoding='utf-8') as f:
    f.write(content)
