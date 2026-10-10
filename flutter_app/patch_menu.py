import os

file_path = 'lib/features/vendor/menu/widgets/menu_widget.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

import_statement = "import 'package:multishop_tchad/features/vendor/transfer_account/screens/transfer_account_list_screen.dart';"
if import_statement not in content:
    content = content.replace("import 'package:multishop_tchad/features/vendor/bank_info/screens/bank_info_screen.dart';", 
                              "import 'package:multishop_tchad/features/vendor/bank_info/screens/bank_info_screen.dart';\n" + import_statement)

old_menu = """          CustomBottomSheetWidget(image: Images.bankingInfo, title: getTranslated('bank_info', context),
            onTap: () => _handleMenuTap(context, const BankInfoScreen()),
          ),"""

new_menu = """          CustomBottomSheetWidget(image: Images.bankingInfo, title: getTranslated('bank_info', context),
            onTap: () => _handleMenuTap(context, const BankInfoScreen()),
          ),

          CustomBottomSheetWidget(image: Images.bankingInfo, title: getTranslated('transfer_accounts', context) ?? 'Comptes de transfert',
            onTap: () => _handleMenuTap(context, const TransferAccountListScreen()),
          ),"""

content = content.replace(old_menu, new_menu)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Menu patched!")
