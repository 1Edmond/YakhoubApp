import re
with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    content = f.read()

vendor_split = content.split('// --- VENDOR APP INIT ---')
if len(vendor_split) == 2:
    vendor_part = vendor_split[1]

    def repl(m):
        return '// ' + m.group(0).replace('\n', '\n// ')

    # 1. AddAuctionProductMediaController
    vendor_part = re.sub(r'sl\.registerFactory\(\(\) => AddAuctionProductMediaController\(\)\);', repl, vendor_part)
    
    # 2. AddAuctionProductController
    vendor_part = re.sub(r'sl\.registerFactory\(\n\s*\(\) =>\n\s*AddAuctionProductController[^\)]+\)\);', repl, vendor_part)
    vendor_part = re.sub(r'sl\.registerFactory\(\(\) =>\n\s*AddAuctionProductController[^\)]+\)\);', repl, vendor_part)

    # 3. auctionTransactionRepo
    vendor_part = re.sub(r'AuctionTransactionRepositoryInterface auctionTransactionRepo =\n\s*AuctionTransactionRepository\(dioClient: sl\(\)\);\n\s*sl\.registerLazySingleton\(\(\) => auctionTransactionRepo\);', repl, vendor_part)

    # 4. auctionTransactionService
    vendor_part = re.sub(r'AuctionTransactionServiceInterface auctionTransactionService =\n\s*AuctionTransactionService\(repositoryInterface: sl\(\)\);\n\s*sl\.registerLazySingleton\(\(\) => auctionTransactionService\);', repl, vendor_part)

    # 5. AuctionTransactionController
    vendor_part = re.sub(r'sl\.registerFactory\(\n\s*\(\) => AuctionTransactionController[^\)]+\)\);', repl, vendor_part)

    content = vendor_split[0] + '// --- VENDOR APP INIT ---' + vendor_part

with open('lib/core/di/di_container.dart', 'w', encoding='utf-8') as f:
    f.write(content)
