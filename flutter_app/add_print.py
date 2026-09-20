import re

def add_print_to_dio(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("dio!.interceptors.add(loggingInterceptor);", "dio!.interceptors.add(loggingInterceptor);\n    print('===============> DIO TIMEOUT CONFIGURÉ À : \ <===============');")
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

add_print_to_dio('lib/core/di/data_sources/dio_client.dart')
add_print_to_dio('lib/core/di/datasource/remote/dio/dio_client.dart')
