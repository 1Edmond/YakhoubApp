with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if 'AddAuctionProductController(addAuctionProductServiceInterface: sl()));' in line:
        if i > 1500: # Only in vendor section
            lines[i] = '// ' + line
            if 'sl.registerFactory(() =>' in lines[i-1]:
                lines[i-1] = '// ' + lines[i-1]
    if '() => AuctionTransactionController(serviceInterface: sl()));' in line:
        if i > 1500:
            lines[i] = '// ' + line
            if 'sl.registerFactory(' in lines[i-1]:
                lines[i-1] = '// ' + lines[i-1]

with open('lib/core/di/di_container.dart', 'w', encoding='utf-8') as f:
    f.writelines(lines)
