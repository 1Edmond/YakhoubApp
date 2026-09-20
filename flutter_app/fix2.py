import re
with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

def comment_block(start_str, end_str=None):
    start_idx = -1
    for i, l in enumerate(lines):
        if start_str in l:
            start_idx = i
            break
    if start_idx == -1: return
    end_idx = start_idx
    if end_str:
        for i in range(start_idx, len(lines)):
            if end_str in lines[i]:
                end_idx = i
                break
    for i in range(start_idx, end_idx + 1):
        lines[i] = '// ' + lines[i]

comment_block('sl.registerFactory(() => CustomerController(')
comment_block('sl.registerFactory(() => ShowBottomSheetController())')
comment_block('sl.registerFactory(() => AddAuctionProductMediaController())', end_str=None) # Only one line
comment_block('AuctionTransactionRepositoryInterface auctionTransactionRepo =', 'sl.registerLazySingleton(() => auctionTransactionRepo);')
comment_block('AuctionTransactionServiceInterface auctionTransactionService =', 'sl.registerLazySingleton(() => auctionTransactionService);')
comment_block('sl.registerFactory(() => v_auction_transaction_controller.AuctionTransactionController(') # Wait, is it multiline?
comment_block('sl.registerFactory(', end_str='() => v_third_party_delivery_man_controller.ThirdPartyDeliverymanController(')
