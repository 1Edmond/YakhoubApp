import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/product_service_interface.dart'
    as v_product_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/product_repository.dart'
    as v_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/customer_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/controllers/show_bottom_sheet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/repositories/product_review_repository.dart'
    as v_product_review_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/repositories/third_party_deliveryman_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/repositories/third_party_deliveryman_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/services/third_party_deliveryman_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/services/third_party_deliveryman_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/controllers/third_party_deliveryman_controller.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- USER IMPORTS ---
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/services/chat_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/services/support_ticket_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/services/profile_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/auction_participation_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/services/review_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/repository/contact_us_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/repositories/refund_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/reposotories/data_sync_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/services/coupon_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/services/profile_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/repository/customer_auction_list_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/controller/auction_transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/dio_client.dart'
    as customer_dio_client;
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/logging_interceptor.dart'
    as customer_interceptor;
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/featured_deal_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/controllers/vat_tax_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/service/transaction_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/service/customer_auction_list_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/repository/contact_us_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/repositories/auction_category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/services/splash_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/repositories/auction_category_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/repositories/shop_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/participation_auction_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/reposotories/data_sync_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/creator/creator_auction_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/creator/creator_auction_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/repository/add_auction_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/repository/auction_ai_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/repositories/category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/repositories/address_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/repository/auction_transaction_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/repositories/splash_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/services/ai_shopping_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/creator/creator_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/services/splash_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/controllers/restock_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/controllers/user_created_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/services/auction_dashboard_summary_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/repository/ai_shopping_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/services/re_order_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/services/auction_ai_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/repositories/compare_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/controllers/ai_shopping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/auction_participation_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/repositories/cart_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/auction_participation_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/services/add_auction_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/services/coupon_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/services/wallet_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/services/product_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/repositories/search_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/repositories/order_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/services/auction_category_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/services/address_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/repositories/wallet_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/repositories/onboarding_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/participation_auction_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/service/auction_transaction_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/services/auction_checkout_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/services/search_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/repositories/review_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/services/ai_shopping_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/services/restock_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/repositories/auction_home_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/repositories/loyalty_point_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/controllers/auction_product_queue_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/repositories/auction_checkout_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/services/review_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/controllers/auction_search_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/auction_participation_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/repositories/coupon_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/repositories/location_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/controllers/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/seller_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/featured_deal_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/repositories/search_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/services/location_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/repositories/support_ticket_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/services/shop_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/repository/auction_product_queue_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/controllers/auction_ai_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/facebook_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/services/address_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/services/cart_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/seller_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/services/auction_dashboard_summary_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/repositories/auction_search_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/repositories/shipping_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_interceptor.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/repository/transaction_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/controllers/re_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/repository/auction_ai_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/services/shipping_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/services/brand_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/services/location_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/services/re_order_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/repositories/compare_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/repositories/brand_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/services/wishlist_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/repositories/notification_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/repositories/category_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/repositories/notification_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/repositories/checkout_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/services/cart_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/repositories/review_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_contoller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/repositories/refund_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/service/vat_tax_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/service/auction_transaction_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/services/auction_ai_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/services/shipping_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/services/support_ticket_service.dart';
import 'package:flutter_sixvalley_ecommerce/core/helpers/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/controllers/transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/services/onboarding_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/services/user_created_auction_list_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/services/category_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/services/banner_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/services/checkout_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/repository/auction_transaction_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/featured_deal_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/services/category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/services/order_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/repositories/support_ticket_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/repositories/chat_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/datasource/remote/dio/logging_interceptor.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/repository/vat_tax_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/flash_deal_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/seller_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/repositories/product_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/services/checkout_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/services/search_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/repository/ai_shopping_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/repository/transaction_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/repositories/address_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/repositories/restock_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/repository/customer_auction_list_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/repository/auction_product_queue_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/repositories/auction_search_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/services/auction_category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/controllers/auction_checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/services/refund_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/services/contact_us_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/flash_deal_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/featured_deal_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/services/order_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/service/transaction_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/services/auction_checkout_service.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/services/data_sync_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/repositories/brand_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/services/compare_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_media_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/repositories/checkout_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/participation_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/controllers/refund_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/auction_participation_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/services/brand_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/services/shop_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/services/loyalty_poin_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/repository/vat_tax_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/repositories/order_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/repositories/auction_home_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/repositories/re_order_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/services/chat_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/services/notification_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/repositories/wishlist_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/participation_auction_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/repositories/order_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/creator/creator_auction_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/services/onboarding_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/repositories/restock_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/repositories/order_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/services/refund_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/services/wishlist_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/services/contact_us_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/flash_deal_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/services/auction_home_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/seller_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/service/customer_auction_list_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/repositories/banner_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/services/order_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/repositories/location_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/services/user_created_auction_list_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/services/auction_search_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/repository/add_auction_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/services/data_sync_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/services/compare_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/repositories/shipping_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/services/add_auction_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/services/loyalty_point_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/controllers/auction_home_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/service/vat_tax_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/participation_auction_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/services/auth_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/controllers/shipping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/repositories/shop_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/repositories/re_order_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/google_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/controllers/auction_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/services/banner_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/services/order_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/services/auction_home_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/repository/user_created_auction_list_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/repositories/auction_checkout_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/repositories/loyalty_point_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/controllers/customer_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/services/auction_search_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/repositories/profile_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/flash_deal_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/services/auction_product_queue_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/controllers/auction_dashboard_summary_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/repositories/banner_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/repositories/product_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/services/product_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/creator/creator_auction_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/services/restock_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/repositories/auth_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/services/notification_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/services/auth_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/services/wallet_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/services/auction_product_queue_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/repository/user_created_auction_list_repository_interface.dart';

// --- VENDOR IMPORTS ---
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_image_controller.dart'
    as v_add_product_image_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_tax_controller.dart'
    as v_add_product_tax_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/digital_product_controller.dart'
    as v_digital_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/variation_controller.dart'
    as v_variation_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/ai/controllers/ai_controller.dart'
    as v_ai_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/ai/domain/repositories/ai_repository.dart'
    as v_ai_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/ai/domain/repositories/ai_repository_interface.dart'
    as v_ai_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/ai/domain/services/ai_service.dart'
    as v_ai_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/ai/domain/services/ai_service_interface.dart'
    as v_ai_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/controllers/auction_product_controller.dart'
    as v_auction_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/controllers/auction_ai_controller.dart'
    as v_auction_ai_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_ai_repository.dart'
    as v_auction_ai_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_ai_repository_interface.dart'
    as v_auction_ai_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_ai_service.dart'
    as v_auction_ai_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_ai_service_interface.dart'
    as v_auction_ai_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_product_repository.dart'
    as v_auction_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_product_repository_interface.dart'
    as v_auction_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_product_service.dart'
    as v_auction_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_product_service_interface.dart'
    as v_auction_product_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/repositories/auth_repository.dart'
    as v_auth_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/repositories/auth_repository_interface.dart'
    as v_auth_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/services/auth_service.dart'
    as v_auth_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/services/auth_service_interface.dart'
    as v_auth_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/domain/repositories/bank_info_repository_interface.dart'
    as v_bank_info_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/domain/services/bank_info_service.dart'
    as v_bank_info_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/domain/services/bank_info_service_interface.dart'
    as v_bank_info_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/barcode/controllers/barcode_controller.dart'
    as v_barcode_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/barcode/domain/repositories/barcode_repository.dart'
    as v_barcode_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/barcode/domain/repositories/barcode_reposity_interface.dart'
    as v_barcode_reposity_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/barcode/domain/services/barcode_service.dart'
    as v_barcode_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/barcode/domain/services/barcode_service_interface.dart'
    as v_barcode_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/domain/repositories/chat_repository_interface.dart'
    as v_chat_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/domain/services/chat_service.dart'
    as v_chat_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/domain/services/chat_service_interface.dart'
    as v_chat_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/clearance_sale/controllers/clearance_sale_controller.dart'
    as v_clearance_sale_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/clearance_sale/domain/repositories/clearance_sale_repository.dart'
    as v_clearance_sale_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/clearance_sale/domain/repositories/clearance_sale_repository_interface.dart'
    as v_clearance_sale_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/clearance_sale/domain/services/clearance_sale_service.dart'
    as v_clearance_sale_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/clearance_sale/domain/services/clearance_sale_service_interface.dart'
    as v_clearance_sale_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/repositories/coupon_repository_interface.dart'
    as v_coupon_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/services/coupon_service.dart'
    as v_coupon_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/services/coupon_service_interface.dart'
    as v_coupon_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/repositories/delivery_man_repository_interface.dart'
    as v_delivery_man_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/repositories/emergency_contract_repository_interface.dart'
    as v_emergency_contract_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/services/delivery_service.dart'
    as v_delivery_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/services/delivery_service_interface.dart'
    as v_delivery_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/services/emergency_contruct_service_interface.dart'
    as v_emergency_contruct_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/services/emergency_service.dart'
    as v_emergency_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/notification/controllers/notification_controller.dart'
    as v_notification_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/notification/domain/repositories/notification_repository.dart'
    as v_notification_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/notification/domain/repositories/notification_repository_interface.dart'
    as v_notification_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/notification/domain/services/notification_service.dart'
    as v_notification_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/notification/domain/services/notification_service_interface.dart'
    as v_notification_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/location_repository_interface.dart'
    as v_location_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/order_repository_interface.dart'
    as v_order_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/services/location_service.dart'
    as v_location_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/services/location_service_interface.dart'
    as v_location_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/services/order_service.dart'
    as v_order_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/services/order_service_interface.dart'
    as v_order_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_details/controllers/order_details_controller.dart'
    as v_order_details_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_details/domain/repositories/order_details_repository.dart'
    as v_order_details_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_details/domain/repositories/order_details_repository_interface.dart'
    as v_order_details_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_details/domain/services/order_details_service.dart'
    as v_order_details_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_details/domain/services/order_details_service_interface.dart'
    as v_order_details_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_edit/controllers/order_edit_controller.dart'
    as v_order_edit_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_edit/domain/repositories/order_edit_repository.dart'
    as v_order_edit_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_edit/domain/repositories/order_edit_repository_interface.dart'
    as v_order_edit_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_edit/domain/services/order_edit_service.dart'
    as v_order_edit_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order_edit/domain/services/order_edit_service_interface.dart'
    as v_order_edit_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/barcode_scan_controller.dart'
    as v_barcode_scan_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/coupon_discount_controller.dart'
    as v_coupon_discount_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/repository/cart_repository_interface.dart'
    as v_cart_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/services/cart_service.dart'
    as v_cart_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/services/cart_service_interface.dart'
    as v_cart_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/controllers/category_controller.dart'
    as v_category_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/category_repository.dart'
    as v_category_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/category_repository_interface.dart'
    as v_category_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/product_repository_interface.dart'
    as v_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/category_service.dart'
    as v_category_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/category_service_interface.dart'
    as v_category_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/product_service.dart'
    as v_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product_details/controllers/product_details_controller.dart'
    as v_product_details_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product_details/domain/repositories/product_details_repository.dart'
    as v_product_details_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product_details/domain/repositories/product_details_repository_interface.dart'
    as v_product_details_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product_details/domain/services/product_details_service.dart'
    as v_product_details_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product_details/domain/services/product_details_service_interface.dart'
    as v_product_details_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/repositories/profile_repository_interface.dart'
    as v_profile_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/services/profice_service_interface.dart'
    as v_profice_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/services/profile_service.dart'
    as v_profile_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/domain/repositories/refund_repository_interface.dart'
    as v_refund_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/domain/services/refund_service.dart'
    as v_refund_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/domain/services/refund_service_interface.dart'
    as v_refund_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/restock/controllers/restock_controller.dart'
    as v_restock_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/restock/domain/repositories/restock_repository.dart'
    as v_restock_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/restock/domain/repositories/restock_repository_interface.dart'
    as v_restock_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/restock/domain/services/restock_service.dart'
    as v_restock_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/restock/domain/services/restock_service_interface.dart'
    as v_restock_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/repositories/product_review_repository_interface.dart'
    as v_product_review_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/services/review_service.dart'
    as v_review_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/services/review_service_interface.dart'
    as v_review_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/repositories/buisness_repository_interface.dart'
    as v_buisness_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/repositories/business_repository.dart'
    as v_business_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/repository/cart_repository.dart'
    as v_cart_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/domain/repositories/chat_repository.dart'
    as v_chat_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/repositories/coupon_repository.dart'
    as v_coupon_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/repositories/delivery_man_repository.dart'
    as v_delivery_man_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/repositories/emergency_contact_repository.dart'
    as v_emergency_contact_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/location_repository.dart'
    as v_location_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/order_repository.dart'
    as v_order_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/repositories/profile_repository.dart'
    as v_profile_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/domain/repositories/refund_repository.dart'
    as v_refund_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/services/business_service.dart'
    as v_business_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/services/business_service_interface.dart'
    as v_business_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/repositories/shipping_repository_interface.dart'
    as v_shipping_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/services/shipping_service.dart'
    as v_shipping_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/services/shipping_service_interface.dart'
    as v_shipping_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/repository/add_product_repository.dart'
    as v_add_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/repositories/shipping_repository.dart'
    as v_shipping_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/repositories/shop_repository.dart'
    as v_shop_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/repository/add_product_repository_interface.dart'
    as v_add_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/services/add_product_service.dart'
    as v_add_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/services/add_product_service_interface.dart'
    as v_add_product_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/repositories/shop_repository_interface.dart'
    as v_shop_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/services/shop_service.dart'
    as v_shop_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/services/shop_service_interface.dart'
    as v_shop_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/repositories/splash_repository.dart'
    as v_splash_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/domain/repositories/bank_info_repository.dart'
    as v_bank_info_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/repositories/splash_repository_interface.dart'
    as v_splash_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/services/splash_service.dart'
    as v_splash_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/services/splash_service_interface.dart'
    as v_splash_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/domain/repositories/transaction_repository.dart'
    as v_transaction_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/controllers/auth_controller.dart'
    as v_auth_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/controllers/business_controller.dart'
    as v_business_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/domain/repositories/transaction_repository_interface.dart'
    as v_transaction_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/domain/services/transaction_service.dart'
    as v_transaction_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/domain/services/transaction_service_interface.dart'
    as v_transaction_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/vat_management/controllers/vat_controller.dart'
    as v_vat_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/vat_management/domain/repositories/vat_repository.dart'
    as v_vat_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/vat_management/domain/repositories/vat_repository_interface.dart'
    as v_vat_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/vat_management/domain/services/vat_service.dart'
    as v_vat_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/vat_management/domain/services/vat_service_interface.dart'
    as v_vat_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/wallet/controllers/wallet_controller.dart'
    as v_wallet_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/wallet/domain/repositories/wallet_repository.dart'
    as v_wallet_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/wallet/domain/repositories/wallet_repository_interface.dart'
    as v_wallet_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/wallet/domain/services/wallet_service.dart'
    as v_wallet_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/wallet/domain/services/wallet_service_interface.dart'
    as v_wallet_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/cart_controller.dart'
    as v_cart_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/controllers/chat_controller.dart'
    as v_chat_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/controllers/coupon_controller.dart'
    as v_coupon_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/controllers/delivery_man_controller.dart'
    as v_delivery_man_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/controllers/emergency_contact_controller.dart'
    as v_emergency_contact_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/language/controllers/language_controller.dart'
    as v_language_controller;
import 'package:flutter_sixvalley_ecommerce/core/localization/controllers/localization_controller.dart'
    as v_localization_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/dashboard/controllers/bottom_menu_controller.dart'
    as v_bottom_menu_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/controllers/location_controller.dart'
    as v_location_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/controllers/order_controller.dart'
    as v_order_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/controllers/product_controller.dart'
    as v_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/controllers/product_review_controller.dart'
    as v_product_review_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/controllers/profile_controller.dart'
    as v_profile_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/controllers/refund_controller.dart'
    as v_refund_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_controller.dart'
    as v_add_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/controllers/shipping_controller.dart'
    as v_shipping_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/controllers/shop_controller.dart'
    as v_shop_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/controllers/splash_controller.dart'
    as v_splash_controller;
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart'
    as v_theme_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/controllers/bank_info_controller.dart'
    as v_bank_info_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/controllers/transaction_controller.dart'
    as v_transaction_controller;
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart'
    as v_app_constants;
import 'package:flutter_sixvalley_ecommerce/common/controller/tutorial_controller.dart'
    as v_tutorial_controller;

final sl = GetIt.instance;

Future<void> init() async {
  // --- USER APP INIT ---

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => customer_interceptor.LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => GuestModeController());
  sl.registerLazySingleton(() => customer_dio_client.DioClient(
      AppConstants.baseUrl, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));
  sl<customer_dio_client.DioClient>().dio!.interceptors.add(
      GuestModeInterceptor(
          isGuestMode: () => sl<GuestModeController>().isGuestMode));

  DataSyncRepoInterface dataSyncRepoInterface =
      DataSyncRepo(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => dataSyncRepoInterface);
  DataSyncServiceInterface dataSyncServiceInterface =
      DataSyncService(dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => dataSyncServiceInterface);

  // Repository
  sl.registerLazySingleton(
      () => DataSyncRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => CategoryRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(() => FlashDealRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      FeaturedDealRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(
      () => BrandRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(
      () => ProductRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(
      () => BannerRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(() => OnBoardingRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => AuthRepository(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => SearchProductRepository(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => ShopRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(() => CouponRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ChatRepository(dioClient: sl()));
  sl.registerLazySingleton(() => NotificationRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepository(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => WishListRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => CartRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(
      () => SplashRepository(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => SupportTicketRepository(dioClient: sl()));
  sl.registerLazySingleton(() => AddressRepository(dioClient: sl()));
  sl.registerLazySingleton(() => WalletRepository(dioClient: sl()));
  sl.registerLazySingleton(() => CompareRepository(dioClient: sl()));
  sl.registerLazySingleton(() => LoyaltyPointRepository(dioClient: sl()));
  sl.registerLazySingleton(() => CheckoutRepository(dioClient: sl()));
  sl.registerLazySingleton(() => LocationRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ShippingRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ContactUsRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      SellerProductRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(() => OrderDetailsRepository(dioClient: sl()));
  sl.registerLazySingleton(() => RefundRepository(dioClient: sl()));
  sl.registerLazySingleton(() => ReOrderRepository(dioClient: sl()));
  sl.registerLazySingleton(() => RestockRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      AuctionCategoryRepository(dioClient: sl(), dataSyncRepoInterface: sl()));
  sl.registerLazySingleton(() =>
      AuctionHomeRepository(dioClient: sl(), dataSyncRepoInterface: sl()));

  // Provider
  sl.registerFactory(() => CategoryController(categoryServiceInterface: sl()));
  sl.registerFactory(() => ShopController(shopServiceInterface: sl()));
  sl.registerFactory(
      () => FlashDealController(flashDealServiceInterface: sl()));
  sl.registerFactory(
      () => FeaturedDealController(featuredDealServiceInterface: sl()));
  sl.registerFactory(() => BrandController(brandRepo: sl()));
  sl.registerFactory(() => ProductController(productServiceInterface: sl()));
  sl.registerFactory(() => BannerController(bannerServiceInterface: sl()));
  sl.registerFactory(
      () => OnBoardingController(onBoardingServiceInterface: sl()));
  sl.registerFactory(() => AuthController(authServiceInterface: sl()));
  sl.registerFactory(
      () => ProductDetailsController(productDetailsServiceInterface: sl()));
  sl.registerFactory(
      () => SearchProductController(searchProductServiceInterface: sl()));
  sl.registerFactory(() => OrderController(orderServiceInterface: sl()));
  sl.registerFactory(() => CouponController(couponRepo: sl()));
  sl.registerFactory(() => ChatController(chatServiceInterface: sl()));
  sl.registerFactory(
      () => NotificationController(notificationServiceInterface: sl()));
  sl.registerFactory(() => ProfileController(profileServiceInterface: sl()));
  sl.registerFactory(() => WishListController(wishlistServiceInterface: sl()));
  sl.registerFactory(() => SplashController(splashServiceInterface: sl()));
  sl.registerFactory(() => CartController(cartServiceInterface: sl()));
  sl.registerFactory(
      () => SupportTicketController(supportTicketServiceInterface: sl()));
  sl.registerFactory(() => LocalizationController(sharedPreferences: sl()));
  sl.registerFactory(() => ThemeController(sharedPreferences: sl()));
  sl.registerFactory(() => GoogleSignInController());
  sl.registerFactory(() => FacebookLoginController());
  sl.registerFactory(() => AddressController(addressServiceInterface: sl()));
  sl.registerFactory(() => WalletController(walletServiceInterface: sl()));
  sl.registerFactory(() => CompareController(compareServiceInterface: sl()));
  sl.registerFactory(
      () => LoyaltyPointController(loyaltyPointServiceInterface: sl()));
  sl.registerFactory(() => CheckoutController(checkoutServiceInterface: sl()));
  sl.registerFactory(
      () => AuctionCheckoutController(auctionCheckoutServiceInterface: sl()));
  sl.registerFactory(() => LocationController(locationServiceInterface: sl()));
  sl.registerFactory(() => ShippingController(shippingServiceInterface: sl()));
  sl.registerFactory(
      () => ContactUsController(contactUsServiceInterface: sl()));
  sl.registerFactory(() => ReviewController(reviewServiceInterface: sl()));
  sl.registerFactory(
      () => SellerProductController(sellerProductServiceInterface: sl()));
  sl.registerFactory(
      () => OrderDetailsController(orderDetailsServiceInterface: sl()));
  sl.registerFactory(() => RefundController(refundServiceInterface: sl()));
  sl.registerFactory(() => ReOrderController(reOrderServiceInterface: sl()));
  sl.registerFactory(() => RestockController(restockServiceInterface: sl()));
  sl.registerFactory(
      () => AuctionCategoryController(auctionCategoryServiceInterface: sl()));
  sl.registerFactory(
      () => AuctionHomeController(auctionHomeServiceInterface: sl()));

  //interface
  AddressRepoInterface addressRepoInterface =
      AddressRepository(dioClient: sl());
  sl.registerLazySingleton(() => addressRepoInterface);
  AddressServiceInterface addressServiceInterface =
      AddressService(addressRepoInterface: sl());
  sl.registerLazySingleton(() => addressServiceInterface);

  AuthRepoInterface authRepoInterface =
      AuthRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => authRepoInterface);
  AuthServiceInterface authServiceInterface =
      AuthService(authRepoInterface: sl());
  sl.registerLazySingleton(() => authServiceInterface);

  BannerRepositoryInterface bannerRepositoryInterface =
      BannerRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => bannerRepositoryInterface);
  BannerServiceInterface bannerServiceInterface =
      BannerService(bannerRepositoryInterface: sl());
  sl.registerLazySingleton(() => bannerServiceInterface);

  BrandRepoInterface brandRepoInterface =
      BrandRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => brandRepoInterface);
  BrandServiceInterface brandServiceInterface =
      BrandService(brandRepoInterface: sl());
  sl.registerLazySingleton(() => brandServiceInterface);

  CartRepositoryInterface cartRepositoryInterface =
      CartRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => cartRepositoryInterface);
  CartServiceInterface cartServiceInterface =
      CartService(cartRepositoryInterface: sl());
  sl.registerLazySingleton(() => cartServiceInterface);

  CategoryRepoInterface categoryRepoInterface =
      CategoryRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => categoryRepoInterface);
  CategoryServiceInterface categoryServiceInterface =
      CategoryService(categoryRepoInterface: sl());
  sl.registerLazySingleton(() => categoryServiceInterface);

  ChatRepositoryInterface chatRepositoryInterface =
      ChatRepository(dioClient: sl());
  sl.registerLazySingleton(() => chatRepositoryInterface);
  ChatServiceInterface chatServiceInterface =
      ChatService(chatRepositoryInterface: sl());
  sl.registerLazySingleton(() => chatServiceInterface);

  ShippingRepositoryInterface shippingRepositoryInterface =
      ShippingRepository(dioClient: sl());
  sl.registerLazySingleton(() => shippingRepositoryInterface);
  ShippingServiceInterface shippingServiceInterface =
      ShippingService(shippingRepositoryInterface: sl());
  sl.registerLazySingleton(() => shippingServiceInterface);

  CheckoutRepositoryInterface checkoutRepositoryInterface =
      CheckoutRepository(dioClient: sl());
  sl.registerLazySingleton(() => checkoutRepositoryInterface);
  CheckoutServiceInterface checkoutServiceInterface =
      CheckoutService(checkoutRepositoryInterface: sl());
  sl.registerLazySingleton(() => checkoutServiceInterface);

  AuctionCheckoutRepositoryInterface auctionCheckoutRepositoryInterface =
      AuctionCheckoutRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionCheckoutRepositoryInterface);
  AuctionCheckoutServiceInterface auctionCheckoutServiceInterface =
      AuctionCheckoutService(auctionCheckoutRepositoryInterface: sl());
  sl.registerLazySingleton(() => auctionCheckoutServiceInterface);

  CompareRepositoryInterface compareRepositoryInterface =
      CompareRepository(dioClient: sl());
  sl.registerLazySingleton(() => compareRepositoryInterface);
  CompareServiceInterface compareServiceInterface =
      CompareService(compareRepositoryInterface: sl());
  sl.registerLazySingleton(() => compareServiceInterface);

  ContactUsRepositoryInterface contactUsRepositoryInterface =
      ContactUsRepository(dioClient: sl());
  sl.registerLazySingleton(() => contactUsRepositoryInterface);
  ContactUsServiceInterface contactUsServiceInterface =
      ContactUsService(contactUsRepositoryInterface: sl());
  sl.registerLazySingleton(() => contactUsServiceInterface);

  CouponRepositoryInterface couponRepositoryInterface =
      CouponRepository(dioClient: sl());
  sl.registerLazySingleton(() => couponRepositoryInterface);
  CouponServiceInterface couponServiceInterface =
      CouponService(couponRepositoryInterface: sl());
  sl.registerLazySingleton(() => couponServiceInterface);

  FlashDealRepositoryInterface flashDealRepositoryInterface =
      FlashDealRepository(dioClient: sl());
  sl.registerLazySingleton(() => flashDealRepositoryInterface);
  FlashDealServiceInterface flashDealServiceInterface =
      FlashDealService(flashDealRepositoryInterface: sl());
  sl.registerLazySingleton(() => flashDealServiceInterface);

  FeaturedDealRepositoryInterface featuredDealRepositoryInterface =
      FeaturedDealRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => featuredDealRepositoryInterface);
  FeaturedDealServiceInterface featuredDealServiceInterface =
      FeaturedDealService(featuredDealRepositoryInterface: sl());
  sl.registerLazySingleton(() => featuredDealServiceInterface);

  LocationRepositoryInterface locationRepositoryInterface =
      LocationRepository(dioClient: sl());
  sl.registerLazySingleton(() => locationRepositoryInterface);
  LocationServiceInterface locationServiceInterface =
      LocationService(locationRepoInterface: sl());
  sl.registerLazySingleton(() => locationServiceInterface);

  LoyaltyPointRepositoryInterface loyaltyPointRepositoryInterface =
      LoyaltyPointRepository(dioClient: sl());
  sl.registerLazySingleton(() => loyaltyPointRepositoryInterface);
  LoyaltyPointServiceInterface loyaltyPointServiceInterface =
      LoyaltyPointService(loyaltyPointRepositoryInterface: sl());
  sl.registerLazySingleton(() => loyaltyPointServiceInterface);

  NotificationRepositoryInterface notificationRepositoryInterface =
      NotificationRepository(dioClient: sl());
  sl.registerLazySingleton(() => notificationRepositoryInterface);
  NotificationServiceInterface notificationServiceInterface =
      NotificationService(notificationRepositoryInterface: sl());
  sl.registerLazySingleton(() => notificationServiceInterface);

  OnBoardingRepositoryInterface onBoardingRepositoryInterface =
      OnBoardingRepository(dioClient: sl());
  sl.registerLazySingleton(() => onBoardingRepositoryInterface);
  OnBoardingServiceInterface onBoardingServiceInterface =
      OnBoardingService(onBoardingRepositoryInterface: sl());
  sl.registerLazySingleton(() => onBoardingServiceInterface);

  OrderRepositoryInterface orderRepositoryInterface =
      OrderRepository(dioClient: sl());
  sl.registerLazySingleton(() => orderRepositoryInterface);
  OrderServiceInterface orderServiceInterface =
      OrderService(orderRepositoryInterface: sl());
  sl.registerLazySingleton(() => orderServiceInterface);

  OrderDetailsRepositoryInterface orderDetailsRepositoryInterface =
      OrderDetailsRepository(dioClient: sl());
  sl.registerLazySingleton(() => orderDetailsRepositoryInterface);
  OrderDetailsServiceInterface orderDetailsServiceInterface =
      OrderDetailsService(orderDetailsRepositoryInterface: sl());
  sl.registerLazySingleton(() => orderDetailsServiceInterface);

  RefundRepositoryInterface refundRepositoryInterface =
      RefundRepository(dioClient: sl());
  sl.registerLazySingleton(() => refundRepositoryInterface);
  RefundServiceInterface refundServiceInterface =
      RefundService(refundRepositoryInterface: sl());
  sl.registerLazySingleton(() => refundServiceInterface);

  ReOrderRepositoryInterface reOrderRepositoryInterface =
      ReOrderRepository(dioClient: sl());
  sl.registerLazySingleton(() => reOrderRepositoryInterface);
  ReOrderServiceInterface reOrderServiceInterface =
      ReOrderService(reOrderRepositoryInterface: sl());
  sl.registerLazySingleton(() => reOrderServiceInterface);

  ReviewRepositoryInterface reviewRepositoryInterface =
      ReviewRepository(dioClient: sl());
  sl.registerLazySingleton(() => reviewRepositoryInterface);
  ReviewServiceInterface reviewServiceInterface =
      ReviewService(reviewRepositoryInterface: sl());
  sl.registerLazySingleton(() => reviewServiceInterface);

  ProductDetailsRepositoryInterface productDetailsRepositoryInterface =
      ProductDetailsRepository(dioClient: sl());
  sl.registerLazySingleton(() => productDetailsRepositoryInterface);
  ProductDetailsServiceInterface productDetailsServiceInterface =
      ProductDetailsService(productDetailsRepositoryInterface: sl());
  sl.registerLazySingleton(() => productDetailsServiceInterface);

  SellerProductRepositoryInterface sellerProductRepositoryInterface =
      SellerProductRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => sellerProductRepositoryInterface);
  SellerProductServiceInterface sellerProductServiceInterface =
      SellerProductService(sellerProductRepositoryInterface: sl());
  sl.registerLazySingleton(() => sellerProductServiceInterface);

  ShopRepositoryInterface shopRepositoryInterface =
      ShopRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => shopRepositoryInterface);
  ShopServiceInterface shopServiceInterface =
      ShopService(shopRepositoryInterface: sl());
  sl.registerLazySingleton(() => shopServiceInterface);

  ProductRepositoryInterface productRepositoryInterface =
      ProductRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => productRepositoryInterface);
  ProductServiceInterface productServiceInterface =
      ProductService(productRepositoryInterface: sl());
  sl.registerLazySingleton(() => productServiceInterface);

  ProfileRepositoryInterface profileRepositoryInterface =
      ProfileRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => profileRepositoryInterface);
  ProfileServiceInterface profileServiceInterface =
      ProfileService(profileRepositoryInterface: sl());
  sl.registerLazySingleton(() => profileServiceInterface);

  SplashRepositoryInterface splashRepositoryInterface =
      SplashRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => splashRepositoryInterface);
  SplashServiceInterface splashServiceInterface =
      SplashService(splashRepositoryInterface: sl());
  sl.registerLazySingleton(() => splashServiceInterface);

  SupportTicketRepositoryInterface supportTicketRepositoryInterface =
      SupportTicketRepository(dioClient: sl());
  sl.registerLazySingleton(() => supportTicketRepositoryInterface);
  SupportTicketServiceInterface supportTicketServiceInterface =
      SupportTicketService(supportTicketRepositoryInterface: sl());
  sl.registerLazySingleton(() => supportTicketServiceInterface);

  WishListRepositoryInterface wishListRepositoryInterface =
      WishListRepository(dioClient: sl());
  sl.registerLazySingleton(() => wishListRepositoryInterface);
  WishlistServiceInterface wishlistServiceInterface =
      WishListService(wishListRepositoryInterface: sl());
  sl.registerLazySingleton(() => wishlistServiceInterface);

  WalletRepositoryInterface walletRepositoryInterface =
      WalletRepository(dioClient: sl());
  sl.registerLazySingleton(() => walletRepositoryInterface);
  WalletServiceInterface walletServiceInterface =
      WalletService(walletRepositoryInterface: sl());
  sl.registerLazySingleton(() => walletServiceInterface);

  SearchProductRepositoryInterface searchProductRepositoryInterface =
      SearchProductRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => searchProductRepositoryInterface);
  SearchProductServiceInterface searchProductServiceInterface =
      SearchProductService(searchProductRepositoryInterface: sl());
  sl.registerLazySingleton(() => searchProductServiceInterface);

  RestockRepositoryInterface restockRepositoryInterface =
      RestockRepository(dioClient: sl());
  sl.registerLazySingleton(() => restockRepositoryInterface);
  RestockServiceInterface restockServiceInterface =
      RestockService(restockRepositoryInterface: sl());
  sl.registerLazySingleton(() => restockServiceInterface);

  // DataSyncRepoInterface dataSyncRepoInterface = DataSyncRepo(dioClient: sl(), sharedPreferences: sl());
  // sl.registerLazySingleton(() => dataSyncRepoInterface);
  // DataSyncServiceInterface dataSyncServiceInterface = DataSyncService(dataSyncRepoInterface: sl());
  // sl.registerLazySingleton(() => dataSyncServiceInterface);

  //services
  sl.registerLazySingleton(() => AddressService(addressRepoInterface: sl()));
  sl.registerLazySingleton(() => AuthService(authRepoInterface: sl()));
  sl.registerLazySingleton(
      () => BannerService(bannerRepositoryInterface: sl()));
  sl.registerLazySingleton(() => BrandService(brandRepoInterface: sl()));
  sl.registerLazySingleton(() => CartService(cartRepositoryInterface: sl()));
  sl.registerLazySingleton(() => CategoryService(categoryRepoInterface: sl()));
  sl.registerLazySingleton(() => ChatService(chatRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ShippingService(shippingRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => CheckoutService(checkoutRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => CompareService(compareRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ContactUsService(contactUsRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => CouponService(couponRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => FlashDealService(flashDealRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => FeaturedDealService(featuredDealRepositoryInterface: sl()));
  sl.registerLazySingleton(() => LocationService(locationRepoInterface: sl()));
  sl.registerLazySingleton(
      () => LoyaltyPointService(loyaltyPointRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => NotificationService(notificationRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => OnBoardingService(onBoardingRepositoryInterface: sl()));
  sl.registerLazySingleton(() => OrderService(orderRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => OrderDetailsService(orderDetailsRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => RefundService(refundRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ReOrderService(reOrderRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ReviewService(reviewRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ProductDetailsService(productDetailsRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => SellerProductService(sellerProductRepositoryInterface: sl()));
  sl.registerLazySingleton(() => ShopService(shopRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ProductService(productRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => ProfileService(profileRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => SplashService(splashRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => SupportTicketService(supportTicketRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => WishListService(wishListRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => WalletService(walletRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => SearchProductService(searchProductRepositoryInterface: sl()));
  sl.registerLazySingleton(
      () => RestockService(restockRepositoryInterface: sl()));

  AuctionCategoryRepoInterface auctionCategoryRepoInterface =
      AuctionCategoryRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => auctionCategoryRepoInterface);
  AuctionCategoryServiceInterface auctionCategoryServiceInterface =
      AuctionCategoryService(auctionCategoryRepoInterface: sl());
  sl.registerLazySingleton(() => auctionCategoryServiceInterface);
  sl.registerLazySingleton(
      () => AuctionCategoryService(auctionCategoryRepoInterface: sl()));

  AuctionHomeRepoInterface auctionHomeRepoInterface =
      AuctionHomeRepository(dioClient: sl(), dataSyncRepoInterface: sl());
  sl.registerLazySingleton(() => auctionHomeRepoInterface);
  AuctionHomeServiceInterface auctionHomeServiceInterface =
      AuctionHomeService(auctionHomeRepoInterface: sl());
  sl.registerLazySingleton(() => auctionHomeServiceInterface);
  sl.registerLazySingleton(
      () => AuctionHomeService(auctionHomeRepoInterface: sl()));

  sl.registerLazySingleton(
      () => AuctionSearchRepository(dioClient: sl(), sharedPreferences: sl()));
  AuctionSearchRepoInterface auctionSearchRepoInterface =
      AuctionSearchRepository(dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => auctionSearchRepoInterface);

  AuctionSearchServiceInterface auctionSearchServiceInterface =
      AuctionSearchService(auctionSearchRepoInterface: sl());
  sl.registerLazySingleton(() => auctionSearchServiceInterface);

  sl.registerFactory(
      () => AuctionSearchController(auctionSearchServiceInterface: sl()));

  sl.registerLazySingleton(() => AddAuctionProductMediaController());

  AddAuctionProductRepositoryInterface addAuctionProductRepositoryInterface =
      AddAuctionProductRepository(dioClient: sl());
  sl.registerLazySingleton(() => addAuctionProductRepositoryInterface);

  AddAuctionProductServiceInterface addAuctionProductServiceInterface =
      AddAuctionProductService(auctionRepoInterface: sl());
  sl.registerLazySingleton(() => addAuctionProductServiceInterface);

  sl.registerFactory(() =>
      AddAuctionProductController(addAuctionProductServiceInterface: sl()));

  sl.registerFactory(() =>
      AuctionProductQueueController(auctionProductQueueServiceInterface: sl()));

  AuctionProductQueueRepositoryInterface repoInterface =
      AuctionProductQueueRepository(dioClient: sl());
  sl.registerLazySingleton(() => repoInterface);

  AuctionProductQueueServiceInterface serviceInterface =
      AuctionProductQueueService(auctionProductRepoInterface: sl());
  sl.registerLazySingleton(() => serviceInterface);

  CreatorAuctionDetailsRepositoryInterface creatorAuctionDetailsRepoInterface =
      CreatorAuctionDetailsRepository(dioClient: sl());
  sl.registerLazySingleton(() => creatorAuctionDetailsRepoInterface);

  CreatorAuctionDetailsServiceInterface creatorAuctionDetailsServiceInterface =
      CreatorAuctionDetailsService(repoInterface: sl());
  sl.registerLazySingleton(() => creatorAuctionDetailsServiceInterface);

  sl.registerFactory(
      () => CreatorAuctionDetailsController(serviceInterface: sl()));

  CustomerAuctionListRepositoryInterface customerAuctionListRepoInterface =
      CustomerAuctionListRepository(dioClient: sl());
  sl.registerLazySingleton(() => customerAuctionListRepoInterface);

  CustomerAuctionListServiceInterface customerAuctionListServiceInterface =
      CustomerAuctionListService(repositoryInterface: sl());
  sl.registerLazySingleton(() => customerAuctionListServiceInterface);

  sl.registerFactory(
      () => CustomerAuctionListController(serviceInterface: sl()));

  VatTaxRepositoryInterface vatTaxRepositoryInterface =
      VatTaxRepository(dioClient: sl());
  sl.registerLazySingleton(() => vatTaxRepositoryInterface);

  VatTaxServiceInterface vatTaxServiceInterface =
      VatTaxService(repositoryInterface: sl());
  sl.registerLazySingleton(() => vatTaxServiceInterface);

  sl.registerFactory(() => VatTaxController(vatTaxServiceInterface: sl()));

  AiShoppingRepositoryInterface aiShoppingRepositoryInterface =
      AiShoppingRepository(dioClient: sl());
  sl.registerLazySingleton(() => aiShoppingRepositoryInterface);

  AiShoppingServiceInterface aiShoppingServiceInterface =
      AiShoppingService(aiShoppingRepositoryInterface: sl());
  sl.registerLazySingleton(() => aiShoppingServiceInterface);

  sl.registerFactory(
      () => AiShoppingController(aiShoppingServiceInterface: sl()));

  AuctionAiRepositoryInterface auctionAiRepositoryInterface =
      AuctionAiRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionAiRepositoryInterface);

  AuctionAiServiceInterface auctionAiServiceInterface =
      AuctionAiService(auctionAiRepositoryInterface: sl());
  sl.registerLazySingleton(() => auctionAiServiceInterface);

  sl.registerFactory(
      () => AuctionAiController(auctionAiServiceInterface: sl()));

  AuctionParticipationRepositoryInterface
      auctionParticipationRepositoryInterface =
      AuctionParticipationRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionParticipationRepositoryInterface);

  AuctionParticipationServiceInterface auctionParticipationServiceInterface =
      AuctionParticipationService(auctionRepositoryInterface: sl());
  sl.registerLazySingleton(() => auctionParticipationServiceInterface);

  sl.registerFactory(() => AuctionParticipationController(
      auctionParticipationServiceInterface: sl()));

  sl.registerLazySingleton<ParticipationAuctionDetailsRepositoryInterface>(
      () => ParticipationAuctionDetailsRepository(dioClient: sl()));

  sl.registerLazySingleton<ParticipationAuctionDetailsServiceInterface>(() =>
      ParticipationAuctionDetailsService(
          participationAuctionDetailsRepositoryInterface: sl()));

  sl.registerFactory(() => ParticipationAuctionDetailsController(
      participationAuctionDetailsServiceInterface: sl()));

  UserCreatedAuctionListRepositoryInterface
      userCreatedAuctionListRepoInterface =
      UserCreatedAuctionListRepository(dioClient: sl());
  sl.registerLazySingleton(() => userCreatedAuctionListRepoInterface);

  UserCreatedAuctionListServiceInterface
      userCreatedAuctionListServiceInterface = UserCreatedAuctionListService(
          userCreatedAuctionListRepositoryInterface: sl());
  sl.registerLazySingleton(() => userCreatedAuctionListServiceInterface);

  sl.registerFactory(() => UserCreatedAuctionListController(
      userCreatedAuctionListServiceInterface: sl()));

  AuctionDashboardSummaryRepositoryInterface auctionDashboardSummaryRepo =
      AuctionDashboardSummaryRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionDashboardSummaryRepo);

  AuctionDashboardSummaryServiceInterface auctionDashboardSummaryService =
      AuctionDashboardSummaryService(repositoryInterface: sl());
  sl.registerLazySingleton(() => auctionDashboardSummaryService);

  sl.registerFactory(
      () => AuctionDashboardSummaryController(serviceInterface: sl()));

  TransactionRepositoryInterface transactionRepositoryInterface =
      TransactionRepository(dioClient: sl());
  sl.registerLazySingleton(() => transactionRepositoryInterface);

  TransactionService(transactionRepositoryInterface: sl());

  sl.registerFactory(
      () => TransactionController(transactionServiceInterface: sl()));

  AuctionTransactionRepositoryInterface auctionTransactionRepositoryInterface =
      AuctionTransactionRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionTransactionRepositoryInterface);

  AuctionTransactionServiceInterface auctionTransactionServiceInterface =
      AuctionTransactionService(repositoryInterface: sl());
  sl.registerLazySingleton(() => auctionTransactionServiceInterface);

  sl.registerFactory(
      () => AuctionTransactionController(serviceInterface: sl()));

  // --- VENDOR APP INIT ---

  // Core
  sl.registerLazySingleton(() => DioClient(
      v_app_constants.AppConstants.baseUrl, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));
  sl<DioClient>().dio!.interceptors.add(GuestModeInterceptor(
      isGuestMode: () => sl<GuestModeController>().isGuestMode));

  // External
  final vendor_sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => vendor_sharedPreferences);
  // sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  // Interface
  v_auth_repository_interface.AuthRepositoryInterface vendor_authRepoInterface =
      v_auth_repository.AuthRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => vendor_authRepoInterface);
  v_bank_info_repository_interface.BankInfoRepositoryInterface
      bankInfoRepoInterface = v_bank_info_repository.BankInfoRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => bankInfoRepoInterface);
  v_chat_repository_interface.ChatRepositoryInterface chatRepoInterface =
      v_chat_repository.ChatRepository(dioClient: sl());
  sl.registerLazySingleton(() => chatRepoInterface);
  v_coupon_repository_interface.CouponRepositoryInterface couponRepoInterface =
      v_coupon_repository.CouponRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => couponRepoInterface);
  v_delivery_man_repository_interface.DeliveryManRepositoryInterface
      deliveryManRepoInterface =
      v_delivery_man_repository.DeliveryManRepository(dioClient: sl());
  sl.registerLazySingleton(() => deliveryManRepoInterface);
  v_emergency_contract_repository_interface.EmergencyContractRepositoryInterface
      emergencyContractRepoInterface =
      v_emergency_contact_repository.EmergencyContactRepository(
          dioClient: sl());
  sl.registerLazySingleton(() => emergencyContractRepoInterface);
  v_order_repository_interface.OrderRepositoryInterface orderRepoInterface =
      v_order_repository.OrderRepository(dioClient: sl());
  sl.registerLazySingleton(() => orderRepoInterface);
  v_product_repository_interface.ProductRepositoryInterface
      productRepoInterface = v_product_repository.ProductRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => productRepoInterface);
  v_profile_repository_interface.ProfileRepositoryInterface
      profileRepoInterface = v_profile_repository.ProfileRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => profileRepoInterface);
  v_refund_repository_interface.RefundRepositoryInterface refundRepoInterface =
      v_refund_repository.RefundRepository(dioClient: sl());
  sl.registerLazySingleton(() => refundRepoInterface);
  v_product_review_repository_interface.ProductReviewRepositoryInterface
      productReviewRepoInterface =
      v_product_review_repository.ProductReviewRepository(dioClient: sl());
  sl.registerLazySingleton(() => productReviewRepoInterface);
  v_buisness_repository_interface.BusinessRepositoryInterface
      businessRepoInterface = v_business_repository.BusinessRepository();
  sl.registerLazySingleton(() => businessRepoInterface);
  v_shipping_repository_interface.ShippingRepositoryInterface
      shippingRepoInterface =
      v_shipping_repository.ShippingRepository(dioClient: sl());
  sl.registerLazySingleton(() => shippingRepoInterface);
  v_add_product_repository_interface.AddProductRepositoryInterface
      addProductRepositoryInterface =
      v_add_product_repository.AddProductRepository(dioClient: sl());
  sl.registerLazySingleton(() => addProductRepositoryInterface);
  v_splash_repository_interface.SplashRepositoryInterface splashRepoInterface =
      v_splash_repository.SplashRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => splashRepoInterface);
  v_transaction_repository_interface.TransactionRepositoryInterface
      transactionRepoInterface =
      v_transaction_repository.TransactionRepository(dioClient: sl());
  sl.registerLazySingleton(() => transactionRepoInterface);
  v_notification_repository_interface.NotificationRepositoryInterface
      notificationRepoInterface =
      v_notification_repository.NotificationRepository(dioClient: sl());
  sl.registerLazySingleton(() => notificationRepoInterface);
  v_wallet_repository_interface.WalletRepositoryInterface walletRepoInterface =
      v_wallet_repository.WalletRepository(dioClient: sl());
  sl.registerLazySingleton(() => walletRepoInterface);
  v_location_repository_interface.LocationRepositoryInterface
      vendor_locationRepositoryInterface =
      v_location_repository.LocationRepository(dioClient: sl());
  sl.registerLazySingleton(() => vendor_locationRepositoryInterface);
  v_cart_repository_interface.CartRepositoryInterface
      vendor_cartRepositoryInterface = v_cart_repository.CartRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => vendor_cartRepositoryInterface);
  v_shop_repository_interface.ShopRepositoryInterface
      vendor_shopRepositoryInterface = v_shop_repository.ShopRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => vendor_shopRepositoryInterface);
  v_order_details_repository_interface.OrderDetailsRepositoryInterface
      vendor_orderDetailsRepositoryInterface =
      v_order_details_repository.OrderDetailsRepository(dioClient: sl());
  sl.registerLazySingleton(() => vendor_orderDetailsRepositoryInterface);
  v_product_details_repository_interface.ProductDetailsRepositoryInterface
      vendor_productDetailsRepositoryInterface =
      v_product_details_repository.ProductDetailsRepository(dioClient: sl());
  sl.registerLazySingleton(() => vendor_productDetailsRepositoryInterface);
  v_barcode_reposity_interface.BarcodeRepositoryInterface
      barcodeRepositoryInterface =
      v_barcode_repository.BarcodeRepository(dioClient: sl());
  sl.registerLazySingleton(() => barcodeRepositoryInterface);
  v_restock_repository_interface.RestockRepositoryInterface
      vendor_restockRepositoryInterface =
      v_restock_repository.RestockRepository(dioClient: sl());
  sl.registerLazySingleton(() => vendor_restockRepositoryInterface);
  v_clearance_sale_repository_interface.ClearanceSaleRepositoryInterface
      clearanceSaleRepositoryInterface =
      v_clearance_sale_repository.ClearanceSaleRepository(dioClient: sl());
  sl.registerLazySingleton(() => clearanceSaleRepositoryInterface);
  v_category_repository_interface.CategoryRepositoryInterface
      categoryRepositoryInterface = v_category_repository.CategoryRepository(
          dioClient: sl(), sharedPreferences: sl());
  sl.registerLazySingleton(() => categoryRepositoryInterface);
  v_vat_repository_interface.VatRepositoryInterface vatRepositoryInterface =
      v_vat_repository.VatRepository(dioClient: sl());
  sl.registerLazySingleton(() => vatRepositoryInterface);
  v_ai_repository_interface.AiRepositoryInterface aiRepositoryInterface =
      v_ai_repository.AiRepository(dioClient: sl());
  sl.registerLazySingleton(() => aiRepositoryInterface);
  v_order_edit_repository_interface.OrderEditRepositoryInterface
      orderEditRepositoryInterface =
      v_order_edit_repository.OrderEditRepository(dioClient: sl());
  sl.registerLazySingleton(() => orderEditRepositoryInterface);
  AddAuctionProductRepositoryInterface
      vendor_addAuctionProductRepositoryInterface =
      AddAuctionProductRepository(dioClient: sl());
//   sl.registerLazySingleton(() => vendor_addAuctionProductRepositoryInterface);
  v_auction_ai_repository_interface.AuctionAiRepositoryInterface
      vendor_auctionAiRepositoryInterface =
      v_auction_ai_repository.AuctionAiRepository(dioClient: sl());
//   sl.registerLazySingleton(() => vendor_auctionAiRepositoryInterface);
  v_auction_product_repository_interface.AuctionProductRepositoryInterface
      auctionProductRepositoryInterface =
      v_auction_product_repository.AuctionProductRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionProductRepositoryInterface);

  // Services
  v_auth_service_interface.AuthServiceInterface vendor_authServiceInterface =
      v_auth_service.AuthService(authRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_authServiceInterface);
  v_bank_info_service_interface.BankInfoServiceInterface
      bankInfoServiceInterface =
      v_bank_info_service.BankInfoService(bankInfoRepoInterface: sl());
  sl.registerLazySingleton(() => bankInfoServiceInterface);
  v_chat_service_interface.ChatServiceInterface vendor_chatServiceInterface =
      v_chat_service.ChatService(chatRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_chatServiceInterface);
  v_coupon_service_interface.CouponServiceInterface
      vendor_couponServiceInterface =
      v_coupon_service.CouponService(couponRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_couponServiceInterface);
  v_delivery_service_interface.DeliveryServiceInterface
      deliveryServiceInterface =
      v_delivery_service.DeliveryService(deliveryManRepoInterface: sl());
  sl.registerLazySingleton(() => deliveryServiceInterface);
  v_emergency_contruct_service_interface.EmergencyServiceInterface
      emergencyServiceInterface = v_emergency_service.EmergencyService(
          emergencyContractRepoInterface: sl());
  sl.registerLazySingleton(() => emergencyServiceInterface);
  v_order_service_interface.OrderServiceInterface vendor_orderServiceInterface =
      v_order_service.OrderService(orderRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_orderServiceInterface);
  v_product_service_interface.ProductServiceInterface
      vendor_productServiceInterface =
      v_product_service.ProductService(productRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_productServiceInterface);
  v_profice_service_interface.ProfileServiceInterface
      vendor_profileServiceInterface =
      v_profile_service.ProfileService(profileRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_profileServiceInterface);
  v_refund_service_interface.RefundServiceInterface
      vendor_refundServiceInterface =
      v_refund_service.RefundService(refundRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_refundServiceInterface);
  v_review_service_interface.ReviewServiceInterface
      vendor_reviewServiceInterface =
      v_review_service.ReviewService(productReviewRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_reviewServiceInterface);
  v_business_service_interface.BusinessServiceInterface
      businessServiceInterface =
      v_business_service.BusinessService(businessRepoInterface: sl());
  sl.registerLazySingleton(() => businessServiceInterface);
  v_shipping_service_interface.ShippingServiceInterface
      vendor_shippingServiceInterface =
      v_shipping_service.ShippingService(shippingRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_shippingServiceInterface);
  v_add_product_service_interface.AddProductServiceInterface
      addProductServiceInterface =
      v_add_product_service.AddProductService(shopRepoInterface: sl());
  sl.registerLazySingleton(() => addProductServiceInterface);
  v_splash_service_interface.SplashServiceInterface
      vendor_splashServiceInterface =
      v_splash_service.SplashService(splashRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_splashServiceInterface);
  v_transaction_service_interface.TransactionServiceInterface
      vendor_transactionServiceInterface =
      v_transaction_service.TransactionService(transactionRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_transactionServiceInterface);

  v_notification_service_interface.NotificationServiceInterface
      vendor_notificationServiceInterface =
      v_notification_service.NotificationService(
          notificationRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_notificationServiceInterface);
  v_wallet_service_interface.WalletServiceInterface
      vendor_walletServiceInterface =
      v_wallet_service.WalletService(walletRepoInterface: sl());
  sl.registerLazySingleton(() => vendor_walletServiceInterface);
  v_location_service_interface.LocationServiceInterface
      vendor_locationServiceInterface =
      v_location_service.LocationService(locationRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_locationServiceInterface);
  v_cart_service_interface.CartServiceInterface vendor_cartServiceInterface =
      v_cart_service.CartService(cartRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_cartServiceInterface);
  v_shop_service_interface.ShopServiceInterface vendor_shopServiceInterface =
      v_shop_service.ShopService(shopRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_shopServiceInterface);
  v_order_details_service_interface.OrderDetailsServiceInterface
      vendor_orderDetailsServiceInterface =
      v_order_details_service.OrderDetailsService(
          orderDetailsRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_orderDetailsServiceInterface);
  v_product_details_service_interface.ProductDetailsServiceInterface
      vendor_productDetailsServiceInterface =
      v_product_details_service.ProductDetailsService(
          productDetailsRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_productDetailsServiceInterface);
  v_barcode_service_interface.BarcodeServiceInterface barcodeServiceInterface =
      v_barcode_service.BarcodeService(barcodeRepositoryInterface: sl());
  sl.registerLazySingleton(() => barcodeServiceInterface);
  v_restock_service_interface.RestockServiceInterface
      vendor_restockServiceInterface =
      v_restock_service.RestockService(restockRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_restockServiceInterface);
  v_clearance_sale_service_interface.ClearanceSaleServiceInterface
      clearanceSaleServiceInterface =
      v_clearance_sale_service.ClearanceSaleService(
          clearanceSaleRepositoryInterface: sl());
  sl.registerLazySingleton(() => clearanceSaleServiceInterface);
  v_category_service_interface.CategoryServiceInterface
      vendor_categoryServiceInterface =
      v_category_service.CategoryService(categoryRepositoryInterface: sl());
  sl.registerLazySingleton(() => vendor_categoryServiceInterface);
  v_vat_service_interface.VatServiceInterface vatServiceInterface =
      v_vat_service.VatService(vatRepoInterface: sl());
  sl.registerLazySingleton(() => vatServiceInterface);
  v_ai_service_interface.AiServiceInterface aiServiceInterface =
      v_ai_service.AiService(aiRepositoryInterface: sl());
  sl.registerLazySingleton(() => aiServiceInterface);
  v_order_edit_service_interface.OrderEditServiceInterface
      orderEditServiceInterface =
      v_order_edit_service.OrderEditService(orderEditRepositoryInterface: sl());
  sl.registerLazySingleton(() => orderEditServiceInterface);
  AddAuctionProductServiceInterface vendor_addAuctionProductServiceInterface =
      AddAuctionProductService(auctionRepoInterface: sl());
// //   sl.registerLazySingleton(() => vendor_addAuctionProductServiceInterface);
  v_auction_ai_service_interface.AuctionAiServiceInterface
      vendor_auctionAiServiceInterface =
      v_auction_ai_service.AuctionAiService(auctionAiRepositoryInterface: sl());
// //   sl.registerLazySingleton(() => vendor_auctionAiServiceInterface);
  v_auction_product_service_interface.AuctionProductServiceInterface
      auctionProductServiceInterface =
      v_auction_product_service.AuctionProductService(
          auctionProductRepoInterface: sl());
// //   sl.registerLazySingleton(() => auctionProductServiceInterface);

  // Repository
  sl.registerLazySingleton(() => v_auth_repository.AuthRepository(
      sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => v_splash_repository.SplashRepository(
      sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => v_profile_repository.ProfileRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => v_shop_repository.ShopRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => v_order_repository.OrderRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_bank_info_repository.BankInfoRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => v_chat_repository.ChatRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_business_repository.BusinessRepository());
  sl.registerLazySingleton(
      () => v_transaction_repository.TransactionRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_add_product_repository.AddProductRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_product_repository.ProductRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() =>
      v_product_review_repository.ProductReviewRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_shipping_repository.ShippingRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_delivery_man_repository.DeliveryManRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_refund_repository.RefundRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_cart_repository.CartRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() =>
      v_emergency_contact_repository.EmergencyContactRepository(
          dioClient: sl()));
  sl.registerLazySingleton(
      () => v_location_repository.LocationRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_coupon_repository.CouponRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => v_notification_repository.NotificationRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_wallet_repository.WalletRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_order_details_repository.OrderDetailsRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      v_product_details_repository.ProductDetailsRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_barcode_repository.BarcodeRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_restock_repository.RestockRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      v_clearance_sale_repository.ClearanceSaleRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_category_repository.CategoryRepository(
      dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => v_vat_repository.VatRepository(dioClient: sl()));
  sl.registerLazySingleton(() => v_ai_repository.AiRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_order_edit_repository.OrderEditRepository(dioClient: sl()));
  sl.registerLazySingleton(() => AddAuctionProductRepository(dioClient: sl()));
  sl.registerLazySingleton(
      () => v_auction_ai_repository.AuctionAiRepository(dioClient: sl()));
  sl.registerLazySingleton(() =>
      v_auction_product_repository.AuctionProductRepository(dioClient: sl()));

  // Controller
  sl.registerFactory(
      () => v_auth_controller.AuthController(authServiceInterface: sl()));
  sl.registerFactory(() => v_bank_info_controller.BankInfoController(
      bankInfoServiceInterface: sl()));
  sl.registerFactory(
      () => v_chat_controller.ChatController(chatServiceInterface: sl()));
  sl.registerFactory(
      () => v_coupon_controller.CouponController(couponServiceInterface: sl()));
  sl.registerFactory(() => v_delivery_man_controller.DeliveryManController(
      deliveryServiceInterface: sl()));
  sl.registerFactory(() =>
      v_emergency_contact_controller.EmergencyContactController(
          emergencyServiceInterface: sl()));
  sl.registerFactory(
      () => v_order_controller.OrderController(orderServiceInterface: sl()));
  sl.registerFactory(() =>
      v_product_controller.ProductController(productServiceInterface: sl()));
  sl.registerFactory(() =>
      v_profile_controller.ProfileController(profileServiceInterface: sl()));
  sl.registerFactory(
      () => v_refund_controller.RefundController(refundServiceInterface: sl()));
  sl.registerFactory(() => v_product_review_controller.ProductReviewController(
      reviewServiceInterface: sl()));
  sl.registerFactory(() =>
      v_business_controller.BusinessController(businessServiceInterface: sl()));
  sl.registerFactory(() =>
      v_shipping_controller.ShippingController(shippingServiceInterface: sl()));
  sl.registerFactory(() => v_add_product_controller.AddProductController(
      shopServiceInterface: sl()));
  sl.registerFactory(
      () => v_splash_controller.SplashController(serviceInterface: sl()));
  sl.registerFactory(() => v_transaction_controller.TransactionController(
      transactionServiceInterface: sl()));
  sl.registerFactory(() => v_notification_controller.NotificationController(
      notificationServiceInterface: sl()));
  sl.registerFactory(
      () => v_wallet_controller.WalletController(walletServiceInterface: sl()));
  sl.registerFactory(() => v_order_details_controller.OrderDetailsController(
      orderDetailsServiceInterface: sl()));
  sl.registerFactory(() =>
      v_product_details_controller.ProductDetailsController(
          productDetailsServiceInterface: sl()));
  sl.registerFactory(
      () => v_theme_controller.ThemeController(sharedPreferences: sl()));
  sl.registerFactory(() => v_localization_controller.LocalizationController(
      sharedPreferences: sl()));
  sl.registerFactory(() => v_language_controller.LanguageController());
  sl.registerFactory(
      () => v_shop_controller.ShopController(shopServiceInterface: sl()));
  sl.registerFactory(
      () => v_cart_controller.CartController(cartServiceInterface: sl()));
  sl.registerFactory(() => v_bottom_menu_controller.BottomMenuController());
  sl.registerFactory(() =>
      v_location_controller.LocationController(locationServiceInterface: sl()));
  sl.registerFactory(() =>
      v_barcode_controller.BarcodeController(barcodeServiceInterface: sl()));
  sl.registerFactory(() =>
      v_restock_controller.RestockController(restockServiceInterface: sl()));
  sl.registerFactory(() => v_clearance_sale_controller.ClearanceSaleController(
      chatServiceInterface: sl()));
  sl.registerFactory(() => CustomerController(cartServiceInterface: sl()));
  sl.registerFactory(() =>
      v_coupon_discount_controller.CouponDiscountController(
          cartServiceInterface: sl()));
  sl.registerFactory(() => v_barcode_scan_controller.BarcodeScanController(
      cartServiceInterface: sl()));
  sl.registerFactory(() => ShowBottomSheetController());
  sl.registerFactory(() => v_tutorial_controller.TutorialController());
  sl.registerFactory(() =>
      v_add_product_image_controller.AddProductImageController(
          shopServiceInterface: sl()));
  sl.registerFactory(() => v_variation_controller.VariationController(
      addProductServiceInterface: sl()));
  sl.registerFactory(() =>
      v_digital_product_controller.DigitalProductController(
          addProductServiceInterface: sl()));
  sl.registerFactory(() =>
      v_category_controller.CategoryController(categoryServiceInterface: sl()));
  sl.registerFactory(() => v_add_product_tax_controller.AddProductTaxController(
      addProductServiceInterface: sl()));
  sl.registerFactory(
      () => v_vat_controller.VatController(vatServiceInterface: sl()));
  sl.registerFactory(
      () => v_ai_controller.AiController(aiServiceInterface: sl()));
  sl.registerFactory(() => v_order_edit_controller.OrderEditController(
      orderEditServiceInterface: sl()));
  sl.registerFactory(() => AddAuctionProductMediaController());
  sl.registerFactory(() => v_auction_ai_controller.AuctionAiController(
      auctionAiServiceInterface: sl()));
  sl.registerFactory(() =>
      v_auction_product_controller.AuctionProductController(
          auctionProductServiceInterface: sl()));
  sl.registerFactory(() =>
      AddAuctionProductController(addAuctionProductServiceInterface: sl()));

  AuctionTransactionRepositoryInterface auctionTransactionRepo =
      AuctionTransactionRepository(dioClient: sl());
  sl.registerLazySingleton(() => auctionTransactionRepo);
  AuctionTransactionServiceInterface auctionTransactionService =
      AuctionTransactionService(repositoryInterface: sl());
  sl.registerLazySingleton(() => auctionTransactionService);
  sl.registerFactory(
      () => AuctionTransactionController(serviceInterface: sl()));

  ThirdPartyDeliverymanRepositoryInterface thirdPartyDeliverymanRepo =
      ThirdPartyDeliverymanRepository(dioClient: sl());
  sl.registerLazySingleton(() => thirdPartyDeliverymanRepo);
  ThirdPartyDeliverymanServiceInterface thirdPartyDeliverymanService =
      ThirdPartyDeliverymanService(repositoryInterface: sl());
  sl.registerLazySingleton(() => thirdPartyDeliverymanService);
  sl.registerFactory(
      () => ThirdPartyDeliverymanController(serviceInterface: sl()));
}
