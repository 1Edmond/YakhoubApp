import re

def fix_dio_client(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    replacement = '''    dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer \',
      'ngrok-skip-browser-warning': '69420',
      'Connection': 'close',
      'Accept-Encoding': 'identity',
      AppConstants.langKey: countryCode == 'US'? 'en':countryCode.toLowerCase(),
    };'''
    
    content = re.sub(r'dio!\.options\.headers = \{(?:[^\}]|(?<=\\)\})*\};', replacement, content, count=0)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

fix_dio_client('lib/core/di/data_sources/dio_client.dart')
fix_dio_client('lib/core/di/datasource/remote/dio/dio_client.dart')
