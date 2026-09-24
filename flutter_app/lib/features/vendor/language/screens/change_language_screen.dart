import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/features/vendor/language/widgets/language_widget.dart';
import 'package:multishop_tchad/features/vendor/localization/language_constrants.dart';
import 'package:multishop_tchad/features/vendor/localization/controllers/localization_controller.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/constants/images.dart';
import 'package:multishop_tchad/core/constants/styles.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_app_bar_widget.dart';


class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: getTranslated('language', context)),

      body: Consumer<LocalizationController>(
        builder: (context,localizationController,_) {
          return SingleChildScrollView(physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: SizedBox(width: MediaQuery.of(context).size.width,
              child: Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start, children: [

                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(child: SizedBox(width: 200, child: Image.asset(Images.logoWithAppName))),
                ),

                const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Text(getTranslated('select_language', context)!, style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  )),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1),
                  ),
                  itemCount: localizationController.languages.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => LanguageWidget(
                    languageModel: localizationController.languages[index],
                    localizationController: localizationController,
                    index: index,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ],
            ),
          ),
          );
      },),
    );
  }
}
