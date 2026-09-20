import re

with open('lib/core/constants/app_constants.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Delete the unused duplicated endpoints block
content = re.sub(r'  // API Versions\n.*?// NNI\n', '// NNI\n', content, flags=re.DOTALL)

# Fix configUri
content = content.replace("static const String configUri = 'config';", "static const String configUri = '/api/v1/config';")

# Fix shopUri if it's 'seller/shop-info' -> maybe '/api/v3/seller/shop-info'
# But let's check if there's already a shopUri.
content = content.replace("static const String shopUri = 'seller/shop-info';", "static const String shopUri = '/api/v3/seller/shop-info';")

with open('lib/core/constants/app_constants.dart', 'w', encoding='utf-8') as f:
    f.write(content)
