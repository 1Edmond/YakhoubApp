import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/features/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/features/auth/enums/from_page.dart';
import 'package:multishop_tchad/features/auth/screens/otp_verification_screen.dart';
import 'package:multishop_tchad/features/customer/splash/controllers/splash_controller.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/images.dart';
import 'package:multishop_tchad/core/widgets/base/custom_button_widget.dart';
import 'package:multishop_tchad/core/widgets/base/show_custom_snakbar_widget.dart';
import 'package:multishop_tchad/core/widgets/base/custom_textfield_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/code_picker_widget.dart';

class MobileVerificationScreen extends StatefulWidget {
  final String tempToken;
  const MobileVerificationScreen(this.tempToken, {super.key});

  @override
  MobileVerificationScreenState createState() => MobileVerificationScreenState();
}

class MobileVerificationScreenState extends State<MobileVerificationScreen> {

  TextEditingController? _numberController;
  final FocusNode _numberFocus = FocusNode();
  String? _countryDialCode = '+235';

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _countryDialCode = CountryCode.fromCountryCode(Provider.of<SplashController>(context, listen: false).configModel?.countryCode ?? 'TD').dialCode ?? '+235';
  }


  @override
  Widget build(BuildContext context) {
    final number = ModalRoute.of(context)!.settings.arguments??'';
    _numberController?.text = number as String;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          physics: const BouncingScrollPhysics(),
          child: Center(child: SizedBox(width: 1170,
              child: Consumer<AuthController>(
                builder: (context, authProvider, child) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Center(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Image.asset(Images.login, matchTextDirection: true,height: MediaQuery.of(context).size.height / 4.5))),
                    const SizedBox(height: Dimensions.paddingSizeLarge),


                    Center(child: Text(getTranslated('mobile_verification', context)??'',)),
                    const SizedBox(height: Dimensions.paddingSizeThirtyFive),


                    Text(getTranslated('mobile_number', context)??'',),
                    const SizedBox(height: Dimensions.paddingSizeSmall),


                    Container(decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [
                        CodePickerWidget(
                          onChanged: (CountryCode countryCode) {
                            _countryDialCode = countryCode.dialCode;
                          },
                          initialSelection: _countryDialCode,
                          favorite: [_countryDialCode??'TD'],
                          showDropDownButton: true,
                          padding: EdgeInsets.zero,
                          showFlagMain: true,
                          textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color)),


                        Expanded(child: CustomTextFieldWidget(
                          hintText: getTranslated('number_hint', context),
                          controller: _numberController,
                          focusNode: _numberFocus,
                          isAmount: true,
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.phone))])),
                    const SizedBox(height: Dimensions.paddingSizeLarge),


                    const SizedBox(height: 12),
                    !authProvider.isPhoneNumberVerificationButtonLoading ?
                    CustomButton(buttonText: getTranslated('continue', context),
                      onTap: () async {
                        String numberChk = _numberController?.text.trim() ?? '';

                        if (numberChk.isEmpty) {
                          showCustomSnackBarWidget(getTranslated('enter_phone_number', context), context, snackBarType: SnackBarType.warning);
                        }
                        else {
                          String number = '${_countryDialCode ?? "+235"}$numberChk';
                          authProvider.sendOtpToPhone(number, widget.tempToken).then((value) async {
                            if (value.isSuccess) {
                              authProvider.updatePhone(number);
                              if (context.mounted) {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (_) => VerificationScreen(number, FromPage.verification, session: widget.tempToken),
                                ));
                              }
                            } else {
                              if (context.mounted) {
                                showCustomSnackBarWidget(getTranslated('phone_number_already_exist', context), context, snackBarType: SnackBarType.error);
                              }
                            }
                          });
                        }
                      },
                    ) :
                    Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
