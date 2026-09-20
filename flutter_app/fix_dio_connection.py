import re

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("'ngrok-skip-browser-warning': '69420',", "'ngrok-skip-browser-warning': '69420',\n        'Connection': 'close',")

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'w', encoding='utf-8') as f:
    f.write(content)
