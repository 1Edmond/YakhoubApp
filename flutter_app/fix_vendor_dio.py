import re

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("..options.connectTimeout = const Duration(seconds: 60)", "..options.connectTimeout = const Duration(seconds: 300)")
content = content.replace("..options.receiveTimeout = const Duration(seconds: 60)", "..options.receiveTimeout = const Duration(seconds: 300)")

if "'ngrok-skip-browser-warning'" not in content:
    content = content.replace("'Accept': 'application/json',", "'Accept': 'application/json',\n        'ngrok-skip-browser-warning': '69420',\n        'Connection': 'close',\n        'Accept-Encoding': 'identity',")

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'w', encoding='utf-8') as f:
    f.write(content)
