import re

def remove_hacky_headers(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("'Connection': 'close',", "")
    content = content.replace("'Accept-Encoding': 'identity',", "")
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

remove_hacky_headers('lib/core/di/data_sources/dio_client.dart')
remove_hacky_headers('lib/core/di/datasource/remote/dio/dio_client.dart')
