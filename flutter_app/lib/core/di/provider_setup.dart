import 'di_container.dart' as di;
import 'package:flutter_sixvalley_ecommerce/core/controllers/show_bottom_sheet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/facebook_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/google_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/controllers/ai_shopping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/controllers/customer_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/controllers/auction_ai_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/controllers/auction_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/controllers/auction_checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/controllers/auction_dashboard_summary_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/creator/creator_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/auction_participation_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/participation_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/controllers/auction_home_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/controllers/auction_product_queue_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/controllers/auction_search_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/controller/auction_transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/controllers/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_contoller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_media_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/controllers/refund_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/controllers/re_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/controllers/restock_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/controllers/shipping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/controllers/transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/controllers/user_created_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/controllers/vat_tax_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/customer_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/controllers/third_party_deliveryman_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => di.sl<AddressController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionParticipationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthController>()),
    ChangeNotifierProvider(create: (_) => di.sl<BannerController>()),
    ChangeNotifierProvider(create: (_) => di.sl<BrandController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CartController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CategoryController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ChatController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CheckoutController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CompareController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CouponController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CustomerController>()),
    ChangeNotifierProvider(create: (_) => di.sl<FacebookLoginController>()),
    ChangeNotifierProvider(create: (_) => di.sl<GoogleSignInController>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<OrderController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ParticipationAuctionDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReOrderController>()),
    ChangeNotifierProvider(create: (_) => di.sl<RefundController>()),
    ChangeNotifierProvider(create: (_) => di.sl<RestockController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReviewController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShippingController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShopController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShowBottomSheetController>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ThemeController>()),
    ChangeNotifierProvider(create: (_) => di.sl<UserCreatedAuctionListController>()),
    ChangeNotifierProvider(create: (_) => di.sl<VatTaxController>()),
    ChangeNotifierProvider(create: (_) => di.sl<WalletController>()),
    ChangeNotifierProvider(create: (_) => di.sl<WishListController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_add_product_controller.AddProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_add_product_tax_controller.AddProductTaxController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_auction_ai_controller.AuctionAiController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_bank_info_controller.BankInfoController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_barcode_scan_controller.BarcodeScanController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_clearance_sale_controller.ClearanceSaleController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_delivery_man_controller.DeliveryManController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_language_controller.LanguageController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_notification_controller.NotificationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_order_details_controller.OrderDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_order_edit_controller.OrderEditController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_product_review_controller.ProductReviewController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_transaction_controller.TransactionController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_variation_controller.VariationController>()),
  ];
}
