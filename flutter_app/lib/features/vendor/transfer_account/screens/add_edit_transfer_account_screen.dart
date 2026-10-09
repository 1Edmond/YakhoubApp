import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/controllers/transfer_account_controller.dart';
import 'package:multishop_tchad/features/vendor/transfer_account/domain/models/transfer_account_model.dart';
import 'package:multishop_tchad/core/widgets/base/custom_app_bar_widget.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_button_widget.dart';
import 'package:multishop_tchad/core/widgets/base/custom_textfield_widget.dart';
import 'package:multishop_tchad/features/vendor/localization/language_constrants.dart';

class AddEditTransferAccountScreen extends StatefulWidget {
  final TransferAccountModel? account;
  const AddEditTransferAccountScreen({super.key, this.account});

  @override
  State<AddEditTransferAccountScreen> createState() => _AddEditTransferAccountScreenState();
}

class _AddEditTransferAccountScreenState extends State<AddEditTransferAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _dailyLimitController = TextEditingController();
  bool _isActive = true;
  int? _selectedOperatorId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransferAccountController>(context, listen: false).getTransferOperators();
    });
    if (widget.account != null) {
      _nameController.text = widget.account!.name ?? '';
      _accountNumberController.text = widget.account!.accountNumber ?? '';
      _dailyLimitController.text = widget.account!.dailyLimit ?? '';
      _isActive = widget.account!.isActive == 1;
      _selectedOperatorId = widget.account!.operatorId;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.account != null;
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated(isEdit ? 'edit_transfer_account' : 'add_transfer_account', context) ?? (isEdit ? 'Edit Account' : 'Add Account'),
      ),
      body: Consumer<TransferAccountController>(
        builder: (context, controller, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                if (controller.transferOperators != null)
                  DropdownButtonFormField<int>(
                    value: _selectedOperatorId,
                    decoration: InputDecoration(
                      hintText: getTranslated('select_operator', context) ?? 'Select Operator',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: controller.transferOperators!.map((operator) {
                      return DropdownMenuItem<int>(
                        value: operator.id,
                        child: Text(operator.name ?? ''),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedOperatorId = value;
                      });
                    },
                    validator: (value) => value == null ? 'Operator is required' : null,
                  ),
                const SizedBox(height: 16),
                CustomTextFieldWidget(
                  controller: _nameController,
                  hintText: getTranslated('account_name', context) ?? 'Account Name',
                ),
                const SizedBox(height: 16),
                CustomTextFieldWidget(
                  controller: _accountNumberController,
                  hintText: getTranslated('account_number', context) ?? 'Account Number',
                ),
                const SizedBox(height: 16),
                CustomTextFieldWidget(
                  controller: _dailyLimitController,
                  hintText: getTranslated('daily_limit', context) ?? 'Daily Limit',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: Text(getTranslated('is_active', context) ?? 'Active'),
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButtonWidget(
                        btnTxt: getTranslated(isEdit ? 'update' : 'save', context) ?? 'Save',
                        onTap: () async {
                          if (_nameController.text.isEmpty || _accountNumberController.text.isEmpty || _selectedOperatorId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields including Operator.')));
                            return;
                          }
                          Map<String, dynamic> data = {
                            'name': _nameController.text,
                            'account_number': _accountNumberController.text,
                            'daily_limit': _dailyLimitController.text,
                            'is_active': _isActive ? 1 : 0,
                            'operator_id': _selectedOperatorId,
                          };

                          if (isEdit) {
                            await controller.updateTransferAccount(widget.account!.id!, data);
                          } else {
                            await controller.addTransferAccount(data);
                          }
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}


