import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/controllers/transfer_account_controller.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/screens/add_edit_transfer_account_screen.dart';
import 'package:multishop_tchad/core/widgets/base/custom_app_bar_widget.dart';
import 'package:multishop_tchad/features/vendor/localization/language_constrants.dart';

class TransferAccountListScreen extends StatefulWidget {
  const TransferAccountListScreen({super.key});

  @override
  State<TransferAccountListScreen> createState() => _TransferAccountListScreenState();
}

class _TransferAccountListScreenState extends State<TransferAccountListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransferAccountController>(context, listen: false).getTransferAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('transfer_accounts', context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEditTransferAccountScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TransferAccountController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.transferAccounts == null || controller.transferAccounts!.isEmpty) {
            return Center(child: Text(getTranslated('no_transfer_account_found', context) ?? 'No transfer account found'));
          }
          return ListView.builder(
            itemCount: controller.transferAccounts!.length,
            itemBuilder: (context, index) {
              final account = controller.transferAccounts![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(account.name ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(account.accountNumber ?? ''),
                      if (account.operatorName != null)
                        Text(account.operatorName!, style: TextStyle(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditTransferAccountScreen(account: account),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


