import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:multishop_tchad/core/widgets/base/basewidgets/custom_image_widget.dart';
import 'package:multishop_tchad/features/vendor/splash/domain/models/business_pages_model.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_app_bar_widget.dart';

class HtmlViewScreen extends StatelessWidget {
  final BusinessPageModel? page;
  const HtmlViewScreen({super.key, required this.page});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(title: page?.title ?? ''),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      child: SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: CustomImageWidget(
                          fit: BoxFit.cover,
                          image: page?.bannerFullUrl?.path ?? "",
                        ),
                      ),
                    ),
                    // const SizedBox(height: Dimensions.paddingSizeSmall),

                    Html(
                      style: {
                        "body": Style(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: FontSize.medium,
                        ),
                      },
                      data: page?.description ?? '',
                    ),

                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
