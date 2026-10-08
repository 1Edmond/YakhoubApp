import os
import re

files = [
    'lib/features/customer/product_details/widgets/promise_widget.dart',
    'lib/features/vault/auction_details/widgets/auction_product_summary_widget.dart',
    'lib/features/vault/create_auction/widgets/product_seo_widget.dart',
    'lib/features/vendor/auction/widgets/basic_setup_widget.dart',
    'lib/features/vendor/auction/widgets/product_additional_image_widget.dart',
    'lib/features/vendor/auction/widgets/product_seo_widget.dart'
]

for file in files:
    if os.path.exists(file):
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove broken backslashes
        content = content.replace("{\\'ngrok-skip-browser-warning\\': \\'true\\'}", "{'ngrok-skip-browser-warning': 'true'}")
        
        with open(file, 'w', encoding='utf-8') as f:
            f.write(content)
