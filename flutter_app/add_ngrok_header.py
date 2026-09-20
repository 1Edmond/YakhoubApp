import re

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("'Accept': 'application/json',", "'Accept': 'application/json',\n        'ngrok-skip-browser-warning': '69420',")

with open('lib/core/di/datasource/remote/dio/dio_client.dart', 'w', encoding='utf-8') as f:
    f.write(content)
