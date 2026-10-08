import os

files = [
    'lib/features/customer/product_details/screens/product_image_screen.dart',
    'lib/features/vault/create_auction/widgets/basic_setup_widget.dart',
    'lib/features/vault/create_auction/widgets/product_additional_image_widget.dart'
]

for file in files:
    if os.path.exists(file):
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        if "import 'package:cached_network_image/cached_network_image.dart';" not in content:
            content = "import 'package:cached_network_image/cached_network_image.dart';\n" + content
            
        content = content.replace(
            "NetworkImage(widget.existingThumbnailUrl!)", 
            "CachedNetworkImageProvider(widget.existingThumbnailUrl!, headers: const {'ngrok-skip-browser-warning': 'true'})"
        )
        content = content.replace(
            "NetworkImage(url)", 
            "CachedNetworkImageProvider(url, headers: const {'ngrok-skip-browser-warning': 'true'})"
        )
        content = content.replace(
            "NetworkImage('${widget.imageList![index].path}')", 
            "CachedNetworkImageProvider('${widget.imageList![index].path}', headers: const {'ngrok-skip-browser-warning': 'true'})"
        )
        
        with open(file, 'w', encoding='utf-8') as f:
            f.write(content)
