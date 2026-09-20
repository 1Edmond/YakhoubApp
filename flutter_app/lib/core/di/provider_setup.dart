import 'di_container.dart' as di;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/common/controller/tutorial_controller.dart'
    as v_tutorial_controller;
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart'
    as v_app_constants;
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/core/controllers/show_bottom_sheet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/dio_client.dart'
    as customer_dio_client;
import 'package:flutter_sixvalley_ecommerce/core/di/data_sources/logging_interceptor.dart'
    as customer_interceptor;
import 'package:flutter_sixvalley_ecommerce/core/di/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/datasource/remote/dio/logging_interceptor.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/reposotories/data_sync_repo.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/reposotories/data_sync_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/services/data_sync_service.dart';
import 'package:flutter_sixvalley_ecommerce/core/di/services/data_sync_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_interceptor.dart';
import 'package:flutter_sixvalley_ecommerce/core/helpers/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/core/localization/controllers/localization_controller.dart'
    as v_localization_controller;
import 'package:flutter_sixvalley_ecommerce/core/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart'
    as v_theme_controller;
import 'package:flutter_sixvalley_ecommerce/core/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/repositories/address_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/repositories/address_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/services/address_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/address/domain/services/address_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/facebook_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/controllers/google_login_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/repositories/auth_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/services/auth_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/auth/domain/services/auth_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/repositories/brand_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/repositories/brand_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/services/brand_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/brand/domain/services/brand_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/repositories/cart_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/services/cart_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/cart/domain/services/cart_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/repositories/category_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/repositories/category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/services/category_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/category/domain/services/category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/controllers/checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/repositories/checkout_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/repositories/checkout_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/services/checkout_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/checkout/domain/services/checkout_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/controllers/location_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/repositories/location_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/repositories/location_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/services/location_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/location/domain/services/location_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/repositories/onboarding_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/services/onboarding_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/onboarding/domain/services/onboarding_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/controllers/order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/repositories/order_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/repositories/order_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/services/order_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order/domain/services/order_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/repositories/order_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/repositories/order_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/services/order_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/order_details/domain/services/order_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/seller_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/repositories/seller_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/seller_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product/domain/services/seller_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/repositories/product_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/repositories/product_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/services/product_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/product_details/domain/services/product_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/repositories/profile_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/services/profile_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/profile/domain/services/profile_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/repositories/search_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/repositories/search_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/services/search_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/search_product/domain/services/search_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/repositories/shop_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/repositories/shop_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/services/shop_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/shop/domain/services/shop_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/repositories/splash_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/services/splash_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/services/splash_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/repositories/chat_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/services/chat_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/chat/domain/services/chat_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/repositories/notification_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/repositories/notification_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/services/notification_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/shared/notification/domain/services/notification_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/controllers/ai_shopping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/repository/ai_shopping_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/repository/ai_shopping_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/services/ai_shopping_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/ai_shopping/domain/services/ai_shopping_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/controllers/customer_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/repository/customer_auction_list_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/repository/customer_auction_list_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/service/customer_auction_list_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction/domain/service/customer_auction_list_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/controllers/auction_ai_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/repository/auction_ai_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/repository/auction_ai_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/services/auction_ai_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_ai/domain/services/auction_ai_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/controllers/auction_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/repositories/auction_category_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/repositories/auction_category_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/services/auction_category_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_category/domain/services/auction_category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/controllers/auction_checkout_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/repositories/auction_checkout_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/repositories/auction_checkout_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/services/auction_checkout_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_checkout/domain/services/auction_checkout_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/controllers/auction_dashboard_summary_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/services/auction_dashboard_summary_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_dashboard_summary/domain/services/auction_dashboard_summary_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/creator/creator_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/auction_participation_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/controllers/participator/participation_auction_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/creator/creator_auction_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/creator/creator_auction_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/auction_participation_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/auction_participation_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/participation_auction_details_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/repositories/participator/participation_auction_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/creator/creator_auction_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/creator/creator_auction_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/auction_participation_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/auction_participation_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/participation_auction_details_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_details/domain/services/participator/participation_auction_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/controllers/auction_home_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/repositories/auction_home_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/repositories/auction_home_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/services/auction_home_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_home/domain/services/auction_home_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/controllers/auction_product_queue_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/repository/auction_product_queue_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/repository/auction_product_queue_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/services/auction_product_queue_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_list/domain/services/auction_product_queue_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/controllers/auction_search_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/repositories/auction_search_repo.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/repositories/auction_search_repo_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/services/auction_search_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_search/domain/services/auction_search_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/controller/auction_transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/repository/auction_transaction_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/repository/auction_transaction_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/service/auction_transaction_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/auction_transaction/domain/service/auction_transaction_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/repositories/banner_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/repositories/banner_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/services/banner_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/banner/domain/services/banner_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/controllers/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/repositories/compare_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/repositories/compare_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/services/compare_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/compare/domain/services/compare_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/repository/contact_us_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/repository/contact_us_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/services/contact_us_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/contact_us/domain/services/contact_us_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/repositories/coupon_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/services/coupon_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/coupon/domain/services/coupon_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_contoller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/controllers/add_auction_product_media_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/repository/add_auction_product_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/repository/add_auction_product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/services/add_auction_product_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/create_auction/domain/services/add_auction_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/featured_deal_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/featured_deal_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/flash_deal_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/repositories/flash_deal_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/featured_deal_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/featured_deal_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/flash_deal_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/deal/domain/services/flash_deal_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/repositories/loyalty_point_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/repositories/loyalty_point_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/services/loyalty_poin_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/loyaltyPoint/domain/services/loyalty_point_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/controllers/refund_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/repositories/refund_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/repositories/refund_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/services/refund_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/refund/domain/services/refund_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/controllers/re_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/repositories/re_order_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/repositories/re_order_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/services/re_order_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/reorder/domain/services/re_order_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/controllers/restock_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/repositories/restock_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/repositories/restock_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/services/restock_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/restock/domain/services/restock_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/repositories/review_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/repositories/review_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/services/review_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/review/domain/services/review_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/controllers/shipping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/repositories/shipping_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/repositories/shipping_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/services/shipping_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/shipping/domain/services/shipping_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/repositories/support_ticket_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/repositories/support_ticket_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/services/support_ticket_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/support/domain/services/support_ticket_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/controllers/transaction_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/repository/transaction_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/repository/transaction_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/service/transaction_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/transaction/domain/service/transaction_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/controllers/user_created_auction_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/repository/user_created_auction_list_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/repository/user_created_auction_list_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/services/user_created_auction_list_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/user_created_auction_list/domain/services/user_created_auction_list_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/controllers/vat_tax_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/repository/vat_tax_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/repository/vat_tax_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/service/vat_tax_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/vat_tax/domain/service/vat_tax_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/repositories/wallet_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/services/wallet_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wallet/domain/services/wallet_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/repositories/wishlist_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/services/wishlist_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vault/wishlist/domain/services/wishlist_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_controller.dart'
    as v_add_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_image_controller.dart'
    as v_add_product_image_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/add_product_tax_controller.dart'
    as v_add_product_tax_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/digital_product_controller.dart'
    as v_digital_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/controllers/variation_controller.dart'
    as v_variation_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/repository/add_product_repository.dart'
    as v_add_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/repository/add_product_repository_interface.dart'
    as v_add_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/services/add_product_service.dart'
    as v_add_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/addProduct/domain/services/add_product_service_interface.dart'
    as v_add_product_service_interface;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/controllers/auction_ai_controller.dart'
    as v_auction_ai_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/controllers/auction_product_controller.dart'
    as v_auction_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_ai_repository.dart'
    as v_auction_ai_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_ai_repository_interface.dart'
    as v_auction_ai_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_product_repository.dart'
    as v_auction_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/repository/auction_product_repository_interface.dart'
    as v_auction_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_ai_service.dart'
    as v_auction_ai_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_ai_service_interface.dart'
    as v_auction_ai_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_product_service.dart'
    as v_auction_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auction/domain/services/auction_product_service_interface.dart'
    as v_auction_product_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/controllers/auth_controller.dart'
    as v_auth_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/repositories/auth_repository.dart'
    as v_auth_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/repositories/auth_repository_interface.dart'
    as v_auth_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/services/auth_service.dart'
    as v_auth_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/auth/domain/services/auth_service_interface.dart'
    as v_auth_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/controllers/bank_info_controller.dart'
    as v_bank_info_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/bank_info/domain/repositories/bank_info_repository.dart'
    as v_bank_info_repository;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/controllers/chat_controller.dart'
    as v_chat_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/chat/domain/repositories/chat_repository.dart'
    as v_chat_repository;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/controllers/coupon_controller.dart'
    as v_coupon_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/repositories/coupon_repository.dart'
    as v_coupon_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/repositories/coupon_repository_interface.dart'
    as v_coupon_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/services/coupon_service.dart'
    as v_coupon_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/coupon/domain/services/coupon_service_interface.dart'
    as v_coupon_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/dashboard/controllers/bottom_menu_controller.dart'
    as v_bottom_menu_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/controllers/delivery_man_controller.dart'
    as v_delivery_man_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/repositories/delivery_man_repository.dart'
    as v_delivery_man_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/repositories/delivery_man_repository_interface.dart'
    as v_delivery_man_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/services/delivery_service.dart'
    as v_delivery_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/delivery_man/domain/services/delivery_service_interface.dart'
    as v_delivery_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/controllers/emergency_contact_controller.dart'
    as v_emergency_contact_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/repositories/emergency_contact_repository.dart'
    as v_emergency_contact_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/repositories/emergency_contract_repository_interface.dart'
    as v_emergency_contract_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/services/emergency_contruct_service_interface.dart'
    as v_emergency_contruct_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/emergency_contract/domain/services/emergency_service.dart'
    as v_emergency_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/language/controllers/language_controller.dart'
    as v_language_controller;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/controllers/location_controller.dart'
    as v_location_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/controllers/order_controller.dart'
    as v_order_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/location_repository.dart'
    as v_location_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/location_repository_interface.dart'
    as v_location_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/order/domain/repositories/order_repository.dart'
    as v_order_repository;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/cart_controller.dart'
    as v_cart_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/coupon_discount_controller.dart'
    as v_coupon_discount_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/controllers/customer_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/repository/cart_repository.dart'
    as v_cart_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/repository/cart_repository_interface.dart'
    as v_cart_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/services/cart_service.dart'
    as v_cart_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/pos/domain/services/cart_service_interface.dart'
    as v_cart_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/controllers/category_controller.dart'
    as v_category_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/controllers/product_controller.dart'
    as v_product_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/category_repository.dart'
    as v_category_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/category_repository_interface.dart'
    as v_category_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/product_repository.dart'
    as v_product_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/repositories/product_repository_interface.dart'
    as v_product_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/category_service.dart'
    as v_category_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/category_service_interface.dart'
    as v_category_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/product_service.dart'
    as v_product_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/product/domain/services/product_service_interface.dart'
    as v_product_service_interface;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/controllers/profile_controller.dart'
    as v_profile_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/repositories/profile_repository.dart'
    as v_profile_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/repositories/profile_repository_interface.dart'
    as v_profile_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/services/profice_service_interface.dart'
    as v_profice_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/profile/domain/services/profile_service.dart'
    as v_profile_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/controllers/refund_controller.dart'
    as v_refund_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/refund/domain/repositories/refund_repository.dart'
    as v_refund_repository;
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
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/controllers/product_review_controller.dart'
    as v_product_review_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/repositories/product_review_repository.dart'
    as v_product_review_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/repositories/product_review_repository_interface.dart'
    as v_product_review_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/services/review_service.dart'
    as v_review_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/review/domain/services/review_service_interface.dart'
    as v_review_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/controllers/business_controller.dart'
    as v_business_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/repositories/buisness_repository_interface.dart'
    as v_buisness_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/repositories/business_repository.dart'
    as v_business_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/services/business_service.dart'
    as v_business_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/settings/domain/services/business_service_interface.dart'
    as v_business_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/controllers/shipping_controller.dart'
    as v_shipping_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/repositories/shipping_repository.dart'
    as v_shipping_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/repositories/shipping_repository_interface.dart'
    as v_shipping_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/services/shipping_service.dart'
    as v_shipping_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shipping/domain/services/shipping_service_interface.dart'
    as v_shipping_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/controllers/shop_controller.dart'
    as v_shop_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/repositories/shop_repository.dart'
    as v_shop_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/repositories/shop_repository_interface.dart'
    as v_shop_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/services/shop_service.dart'
    as v_shop_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/shop/domain/services/shop_service_interface.dart'
    as v_shop_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/controllers/splash_controller.dart'
    as v_splash_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/repositories/splash_repository.dart'
    as v_splash_repository;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/repositories/splash_repository_interface.dart'
    as v_splash_repository_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/services/splash_service.dart'
    as v_splash_service;
import 'package:flutter_sixvalley_ecommerce/features/vendor/splash/domain/services/splash_service_interface.dart'
    as v_splash_service_interface;
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/controllers/third_party_deliveryman_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/repositories/third_party_deliveryman_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/repositories/third_party_deliveryman_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/services/third_party_deliveryman_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/third_party_deliveryman/domain/services/third_party_deliveryman_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/controllers/transaction_controller.dart'
    as v_transaction_controller;
import 'package:flutter_sixvalley_ecommerce/features/vendor/transaction/domain/repositories/transaction_repository.dart'
    as v_transaction_repository;
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
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (_) => di.sl<AddAuctionProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddressController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AiShoppingController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionAiController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionCategoryController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionCheckoutController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionDashboardSummaryController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionHomeController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionParticipationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionProductQueueController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionSearchController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuctionTransactionController>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthController>()),
    ChangeNotifierProvider(create: (_) => di.sl<BannerController>()),
    ChangeNotifierProvider(create: (_) => di.sl<BrandController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CartController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CategoryController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ChatController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CheckoutController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CompareController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ContactUsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CouponController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CreatorAuctionDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CustomerAuctionListController>()),
    ChangeNotifierProvider(create: (_) => di.sl<CustomerController>()),
    ChangeNotifierProvider(create: (_) => di.sl<FacebookLoginController>()),
    ChangeNotifierProvider(create: (_) => di.sl<FeaturedDealController>()),
    ChangeNotifierProvider(create: (_) => di.sl<FlashDealController>()),
    ChangeNotifierProvider(create: (_) => di.sl<GoogleSignInController>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<LoyaltyPointController>()),
    ChangeNotifierProvider(create: (_) => di.sl<NotificationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<OnBoardingController>()),
    ChangeNotifierProvider(create: (_) => di.sl<OrderController>()),
    ChangeNotifierProvider(create: (_) => di.sl<OrderDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ParticipationAuctionDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProductDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReOrderController>()),
    ChangeNotifierProvider(create: (_) => di.sl<RefundController>()),
    ChangeNotifierProvider(create: (_) => di.sl<RestockController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReviewController>()),
    ChangeNotifierProvider(create: (_) => di.sl<SearchProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<SellerProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShippingController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShopController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ShowBottomSheetController>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashController>()),
    ChangeNotifierProvider(create: (_) => di.sl<SupportTicketController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ThemeController>()),
    ChangeNotifierProvider(create: (_) => di.sl<ThirdPartyDeliverymanController>()),
    ChangeNotifierProvider(create: (_) => di.sl<TransactionController>()),
    ChangeNotifierProvider(create: (_) => di.sl<UserCreatedAuctionListController>()),
    ChangeNotifierProvider(create: (_) => di.sl<VatTaxController>()),
    ChangeNotifierProvider(create: (_) => di.sl<WalletController>()),
    ChangeNotifierProvider(create: (_) => di.sl<WishListController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_add_product_controller.AddProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_add_product_image_controller.AddProductImageController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_add_product_tax_controller.AddProductTaxController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_ai_controller.AiController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_auction_ai_controller.AuctionAiController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_auction_product_controller.AuctionProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_auth_controller.AuthController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_bank_info_controller.BankInfoController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_barcode_controller.BarcodeController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_barcode_scan_controller.BarcodeScanController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_business_controller.BusinessController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_cart_controller.CartController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_category_controller.CategoryController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_chat_controller.ChatController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_clearance_sale_controller.ClearanceSaleController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_coupon_controller.CouponController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_coupon_discount_controller.CouponDiscountController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_delivery_man_controller.DeliveryManController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_digital_product_controller.DigitalProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_emergency_contact_controller.EmergencyContactController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_language_controller.LanguageController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_location_controller.LocationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_notification_controller.NotificationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_order_controller.OrderController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_order_details_controller.OrderDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_order_edit_controller.OrderEditController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_product_controller.ProductController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_product_details_controller.ProductDetailsController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_product_review_controller.ProductReviewController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_profile_controller.ProfileController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_refund_controller.RefundController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_restock_controller.RestockController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_shipping_controller.ShippingController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_shop_controller.ShopController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_transaction_controller.TransactionController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_variation_controller.VariationController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_vat_controller.VatController>()),
    ChangeNotifierProvider(create: (_) => di.sl<v_wallet_controller.WalletController>()),
  ];
}
