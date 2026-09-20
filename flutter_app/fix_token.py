import re

def fix_dio_client(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("'Authorization': 'Bearer ',", "'Authorization': 'Bearer " + "$" + "token',")
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

fix_dio_client('lib/core/di/data_sources/dio_client.dart')
fix_dio_client('lib/core/di/datasource/remote/dio/dio_client.dart')
