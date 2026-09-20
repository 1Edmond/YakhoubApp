import 'package:flutter_sixvalley_ecommerce/core/localization/models/language_model.dart';
import 'package:flutter_sixvalley_ecommerce/core/enums/local_caches_type_enum.dart';

class AppConstants {
  static const String baseUrl =
      'https://0442-194-71-130-44.ngrok-free.app/admin';
  static const String appName = 'MultiShop Tchad';
  static const String packageName = 'com.multishop.tchad';

// NNI
  static const String nniVerifyEndpoint = 'nni/verify';
  static const String nniUploadDocumentEndpoint = 'nni/upload-document';

  // Price Reduction
  static const String reductionTiersEndpoint = 'reduction-tiers';
  static const String customerReductionRequestEndpoint =
      'customer/orders/{orderId}/request-reduction';
  static const String customerReductionRequestsEndpoint =
      'customer/reduction-requests';
  static const String customerReductionRespondEndpoint =
      'customer/reduction-requests/{requestId}/respond';
  static const String vendorReductionRequestsEndpoint =
      'v3/seller/reduction-requests';
  static const String vendorReductionAcceptEndpoint =
      'v3/seller/reduction-requests/{requestId}/accept';
  static const String vendorReductionRefuseEndpoint =
      'v3/seller/reduction-requests/{orderId}/refuse';
  static const String vendorReductionCounterOfferEndpoint =
      'v3/seller/reduction-requests/{requestId}/counter-offer';

  // Order Cancellation
  static const String orderCancelEndpoint = 'customer/order/{orderId}/cancel';

  // Door Photo
  static const String doorPhotoUploadEndpoint =
      'customer/order/{orderId}/door-photo';

  // Mobile Payments
  static const String paymentAirtelEndpoint = 'payments/airtel';
  static const String paymentMoovEndpoint = 'payments/moov';
  static const String paymentStatusEndpoint = 'payments/{paymentId}/status';
  static const String paymentWebhookAirtelEndpoint = 'payments/webhook/airtel';
  static const String paymentWebhookMoovEndpoint = 'payments/webhook/moov';

  // Digital Payment
  static const String digitalPaymentEndpoint = 'digital-payment';
  static const String addToFundEndpoint = 'add-to-fund';

  // Paliers de réduction (FCFA)
  static const List<int> reductionTiers = [
    250,
    500,
    1000,
    1500,
    2000,
    2500,
    3000,
    3500,
    4000,
    5000,
    10000
  ];

  // Frais d'annulation (FCFA)
  static const double cancellationFee = 1000.00;

  // Langues supportées
  static List<LanguageModel> languages = [
    LanguageModel(
        languageCode: 'fr', countryCode: 'TD', languageName: 'Français'),
    LanguageModel(
        languageCode: 'ar', countryCode: 'TD', languageName: 'العربية'),
  ];

  // Rôles utilisateur
  static const String roleCustomer = 'customer';
  static const String roleVendor = 'vendor';
  static const String roleAdmin = 'admin';

// Stockage
  static const String tokenKey = 'token';
  static const String userLoginToken = 'user_login_token';
  static const String userKey = 'user';
  static const String languageCodeKey = 'language_code';
  static const String countryCodeKey = 'country_code';
  static const String langKey = 'lang';
  static const String themeModeKey = 'theme_mode';
  static const String fcmTokenKey = 'fcm_token';
  static const String guestIdKey = 'guest_id';
  static const String vaultPinHashKey = 'vault_pin_hash';
  static const String vaultEnabledFeaturesKey = 'vault_enabled_features';
  static const String configUri = '/api/v1/config';
  static const String version = '1.0.0';
  static const String shopUri = '/api/v3/seller/shop-info';

  // Firebase
  static const String firebaseApiKey =
      'AIzaSyCFGqSEiWMItei_AFIUgdM53PWrvyGmjFY';
  static const String firebaseProjectId = 'drivevalley-fdb7f';
  static const String firebaseMessagingSenderId = '76471554747';
  static const String firebaseAppId =
      '1:76471554747:android:3aa5d58a094e2a036d0f9e';

  // Google Maps
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // Airtel / Moov Money (à configurer via variables d'environnement)
  static const String airtelMoneyApiKey = ''; // AIRTEL_MONEY_API_KEY
  static const String moovMoneyApiKey = ''; // MOOV_MONEY_API_KEY

  // Image compression
  static const int imageCompressionQuality = 80;
  static const int imageMaxWidth = 1024;
  static const int imageMaxHeight = 1024;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Timeouts
  static const int connectTimeout = 30000; // 30s
  static const int receiveTimeout = 30000; // 30s

  // Cache
  static const int cacheMaxAge = 86400000; // 24h en ms
  static const int cacheMaxSize = 50 * 1024 * 1024; // 50MB
  // Vendor app specific constants
  static const String appVersion = '16.5';
  static const String companyName = '6Valley';
  static const bool demo = false;
  static const int imageQuality = 100;
  static const String loginUri = '/api/v3/seller/auth/login';
  static const String sellerUri = '/api/v3/seller/seller-info';
  static const String sellerAndBankUpdate = '/api/v3/seller/seller-update';
  static const String shopUpdate = '/api/v3/seller/shop-update';
  static const String cartUri = '/api/v3/seller/messages/list/';
  static const String chatSearchUri = '/api/v3/seller/messages/search/';
  static const String messageUri = '/api/v3/seller/messages/get-message/';
  static const String sendMessageUri = '/api/v3/seller/messages/send/';
  static const String seenMessageUri = '/api/v3/seller/messages/seen/';
  static const String orderListUri = '/api/v3/seller/orders/list';
  static const String orderDetails = '/api/v3/seller/orders/';
  static const String updateOrderStatus =
      '/api/v3/seller/orders/order-detail-status/';
  static const String balanceWithdraw = '/api/v3/seller/balance-withdraw';
  static const String balanceWithdrawUpdate =
      '/api/v3/seller/balance-withdraw-update';
  static const String cancelBalanceRequest =
      '/api/v3/seller/close-withdraw-request';
  static const String transactionUri = '/api/v3/seller/transactions?status=';
  static const String sellerProductUri = '/api/v3/seller/products/';
  static const String stockOutProductUri =
      '/api/v3/seller/products/stock-out-list?limit=10&offset=';
  static const String productReviewUri = '/api/v3/seller/shop-product-reviews';
  static const String productReviewStatusOnOff =
      '/api/v3/seller/shop-product-reviews-status';
  static const String attributeUri = '/api/v1/attributes';
  static const String brandUri = '/api/v3/seller/brands';
  static const String categoryUri = '/api/v3/seller/categories';
  static const String subCategoryUri = '/api/v1/categories/childes/';
  static const String subSubCategoryUri = '/api/v1/categories/childes/childes/';
  static const String addProductUri = '/api/v3/seller/products/add';
  static const String uploadProductImageUri =
      '/api/v3/seller/products/upload-images';
  static const String updateProductUri = '/api/v3/seller/products/update';
  static const String deleteProductUri = '/api/v3/seller/products/delete';
  static const String editProductUri = '/api/v3/seller/products/edit';
  static const String addShippingUri = '/api/v3/seller/shipping-method/add';
  static const String updateShippingUri =
      '/api/v3/seller/shipping-method/update';
  static const String editShippingUri = '/api/v3/seller/shipping-method/edit';
  static const String deleteShippingUri =
      '/api/v3/seller/shipping-method/delete';
  static const String getShippingUri = '/api/v3/seller/shipping-method/list';
  static const String getDeliveryManUri = '/api/v3/seller/seller-delivery-man';
  static const String assignDeliveryManUri =
      '/api/v3/seller/orders/assign-delivery-man';
  static const String tokenUri = '/api/v3/seller/cm-firebase-token';
  static const String refundListUri = '/api/v3/seller/refund/list';
  static const String refundItemDetails =
      '/api/v3/seller/refund/refund-details';
  static const String refundReqStatusUpdate =
      '/api/v3/seller/refund/refund-status-update';
  static const String showShippingCostUri =
      '/api/v3/seller/shipping/all-category-cost';
  static const String setCategoryWiseShippingCost =
      '/api/v3/seller/shipping/set-category-cost';
  static const String setShippingMethodTypeUri =
      '/api/v3/seller/shipping/selected-shipping-method';
  static const String getShippingMethodTypeUri =
      '/api/v3/seller/shipping/get-shipping-method';
  static const String thirdPartyDeliveryManAssign =
      '/api/v3/seller/orders/assign-third-party-delivery';
  static const String forgotPasswordUri = '/api/v3/seller/auth/forgot-password';
  static const String verifyOtpUri = '/api/v3/seller/auth/verify-otp';
  static const String resetPasswordUri = '/api/v3/seller/auth/reset-password';
  static const String paymentStatusUpdate =
      '/api/v3/seller/orders/update-payment-status';
  static const String barCodeGenerateUri =
      '/api/v3/seller/products/barcode/generate';
  static const String digitalProductUpload =
      '/api/v3/seller/products/upload-digital-product';
  static const String digitalProductUploadAfterSell =
      '/api/v3/seller/orders/order-wise-product-upload';
  static const String registration = '/api/v3/seller/registration';
  static const String deleteAccount = '/api/v3/seller/account-delete';
  static const String deliveryChargeForDelivery =
      '/api/v3/seller/orders/delivery-charge-date-update';
  static const String digitalAuthorList =
      '/api/v3/seller/products/digital-author-list';
  static const String digitalPublishingHouse =
      '/api/v3/seller/products/digital-publishing-house-list';
  static const String getCouponDiscount = '/api/v3/seller/coupon/check-coupon';
  static const String placeOrderUri = '/api/v3/seller/pos/place-order';
  static const String getProductFromProductCode = '/api/v3/seller/pos/products';
  static const String customerSearchUri = '/api/v3/seller/pos/customers';
  static const String invoice = '/api/v3/seller/pos/get-invoice';
  static const String topSellingProduct =
      '/api/v3/seller/products/top-selling-product?limit=10&offset=';
  static const String mostPopularProduct =
      '/api/v3/seller/products/most-popular-product?limit=10&offset=';
  static const String topDeliveryMan = '/api/v3/seller/top-delivery-man';
  static const String deliveryManListUri = '/api/v3/seller/delivery-man/list';
  static const String deliveryManDetails =
      '/api/v3/seller/delivery-man/details/';
  static const String posProductList = '/api/v3/seller/pos/product-list';
  static const String searchPosProductList = '/api/v3/seller/pos/product-list';
  static const String shippingMethodOnOff =
      '/api/v3/seller/shipping-method/status';
  static const String updateProductQuantity =
      '/api/v3/seller/products/quantity-update';
  static const String productWiseReviewList =
      '/api/v3/seller/products/review-list/';
  static const String addDeliveryMan = '/api/v3/seller/delivery-man/store';
  static const String updateDeliveryMan = '/api/v3/seller/delivery-man/update';
  static const String deleteDeliveryman = '/api/v3/seller/delivery-man/delete/';
  static const String deliveryManOrderHistory =
      '/api/v3/seller/delivery-man/order-list/';
  static const String deliveryManEarning =
      '/api/v3/seller/delivery-man/earning/';
  static const String collectCashFromDeliveryMan =
      '/api/v3/seller/delivery-man/cash-receive';
  static const String emergencyContactAdd =
      '/api/v3/seller/delivery-man/emergency-contact/store';
  static const String emergencyContactUpdate =
      '/api/v3/seller/delivery-man/emergency-contact/update';
  static const String getEmergencyContactList =
      '/api/v3/seller/delivery-man/emergency-contact/list';
  static const String emergencyContactStatusOnOff =
      '/api/v3/seller/delivery-man/emergency-contact/status-update';
  static const String emergencyContactDelete =
      '/api/v3/seller/delivery-man/emergency-contact/delete';
  static const String deliveryManWithdrawList =
      '/api/v3/seller/delivery-man/withdraw/list';
  static const String deliveryManReviewList =
      '/api/v3/seller/delivery-man/reviews/';
  static const String deliveryManWithdrawDetails =
      '/api/v3/seller/delivery-man/withdraw/details/';
  static const String deliveryManWithdrawApprovedRejected =
      '/api/v3/seller/delivery-man/withdraw/status-update';
  static const String addNewCustomer = '/api/v3/seller/pos/customer-store';
  static const String productStatusOnOff =
      '/api/v3/seller/products/status-update';
  static const String deliveryManStatusOnOff =
      '/api/v3/seller/delivery-man/status-update';
  static const String businessAnalytics =
      '/api/v3/seller/order-statistics?statistics_type=';
  static const String productDetails = '/api/v3/seller/products/details/';
  static const String deliveryManOrderChangeLog =
      '/api/v3/seller/delivery-man/order-status-history/';
  static const String chartFilterData =
      '/api/v3/seller/get-earning-statitics?type=';
  static const String addNewCoupon = '/api/v3/seller/coupon/store';
  static const String getCouponList = '/api/v3/seller/coupon/list';
  static const String updateCoupon = '/api/v3/seller/coupon/update/';
  static const String deleteCoupon = '/api/v3/seller/coupon/delete/';
  static const String couponStatusUpdate =
      '/api/v3/seller/coupon/status-update/';
  static const String deliveryManCollectedCashList =
      '/api/v3/seller/delivery-man/collect-cash-list/';
  static const String couponCustomerList =
      '/api/v3/seller/coupon/customers?name=';
  static const String temporaryClose = '/api/v3/seller/temporary-close';
  static const String vacation = '/api/v3/seller/vacation-add';
  static const String dynamicWithdrawMethod =
      '/api/v3/seller/withdraw-method-list';
  static const String orderAddressEdit = '/api/v3/seller/orders/address-update';
  static const String getNotificationList =
      '/api/v3/seller/notification?limit=20&offset=';
  static const String seenNotification = '/api/v3/seller/notification/view?id=';
  static const String stockLimitStatus =
      '/api/v3/seller/products/stock-limit-status';
  static const String reviewReply = '/api/v3/seller/shop-product-reviews-reply';
  static const String deleteDigitalProductVariationFile =
      '/api/v3/seller/products/delete-digital-product';
  static const String getSingleRefundModel =
      '/api/v3/seller/refund/single-item?id=';
  static const String getRestockList =
      '/api/v3/seller/products/restock-request-list';
  static const String restockUpdateProductQuantity =
      '/api/v3/seller/products/restock-request-stock-update';
  static const String restockBrandListUri =
      '/api/v3/seller/products/restock-request-brands-list';
  static const String restockRequestDelete =
      '/api/v3/seller/products/restock-request-delete?id=';
  static const String clearanceSaleProductList =
      '/api/v3/seller/clearance-sale/product-list';
  static const String clearanceSaleDeleteProduct =
      '/api/v3/seller/clearance-sale/product-delete?product_id=';
  static const String clearanceSaleDeleteAllProduct =
      '/api/v3/seller/clearance-sale/all-product-delete';
  static const String clearanceSaleProductStatusUpdate =
      '/api/v3/seller/clearance-sale/product-status-update';
  static const String clearanceSaleProductDiscountUpdate =
      '/api/v3/seller/clearance-sale/product-discount-update';
  static const String clearanceSaleConfigStatusUpdate =
      '/api/v3/seller/clearance-sale/config-status-update';
  static const String clearanceSaleConfigData =
      '/api/v3/seller/clearance-sale/config-data';
  static const String clearanceSaleConfigDataUpdate =
      '/api/v3/seller/clearance-sale/config-data-update';
  static const String clearanceSaleProductAdd =
      '/api/v3/seller/clearance-sale/product-add';
  static const String setUpOrder =
      '/api/v3/seller/orders/order-detail-info-update';
  static const String businessPagesUri = '/api/v1/business-pages?type=';
  static const String paymentWithdrawalMethodList =
      '/api/v3/seller/payment-information/withdrawal-method-list';
  static const String paymentInformationAdd =
      '/api/v3/seller/payment-information/add';
  static const String paymentInformationList =
      '/api/v3/seller/payment-information/list';
  static const String paymentInformationStatusUpdate =
      '/api/v3/seller/payment-information/status';
  static const String paymentInformationDelete =
      '/api/v3/seller/payment-information/delete';
  static const String paymentInformationDefault =
      '/api/v3/seller/payment-information/default';
  static const String paymentInformationUpdate =
      '/api/v3/seller/payment-information/update';
  static const String updateSetupGuideApp =
      '/api/v3/seller/update-setup-guide-app';
  static const String getTaxVatList = '/api/v1/vat-tax/get-taxVat-list';
  static const String getTaxAmount = '/api/v3/seller/pos/get-tax-amount';
  static const String getVatTaxReportList =
      '/api/v3/seller/get-vat-tax-report-list';
  static const String auctionVatTaxReportList =
      '/api/v3/seller/auction/get-vat-tax-report-list';
  static const String firebaseAuthTokenStore =
      '/api/v3/seller/auth/firebase-auth-token-store';
  static const String firebaseAuthVerify =
      '/api/v3/seller/auth/firebase-auth-verify';
  static const String checkVendorExistInfoPhone =
      '/api/v3/seller/auth/check-vendor-exist-info';
  static const String generateInvoice =
      '/api/v1/customer/order/generate-invoice?order_id=';
  static const String editOrderSubmit =
      '/api/v3/seller/orders/edit-order-submit';
  static const String editOrderValidation =
      '/api/v3/seller/orders/edit-order-validation';
  static const String switchToCod = '/api/v3/seller/orders/assign-order-in-cod';
  static const String editOrderAllProducts = '/api/v3/seller/products/';
  static const String addAuctionProductUri =
      '/api/v3/seller/auction/products/store';
  static const String auctionProductListUri =
      '/api/v3/seller/auction/products/list';
  static const String deleteAuctionProductUri =
      '/api/v3/seller/auction/products/delete/';
  static const String updateAuctionProductUri =
      '/api/v3/seller/auction/products/update';
  static const String vendorAuctionDetailsUri =
      '/api/v3/seller/auction/products/details/';
  static const String vendorAuctionStatusToggle =
      '/api/v3/seller/auction/products/status/';
  static const String vendorAuctionBidsList =
      '/api/v3/seller/auction/bids/list/';
  static const String relaunchAuctionProductUri =
      '/api/v3/seller/auction/products/relaunch/';
  static const String auctionWithdrawRequest =
      '/api/v3/seller/auction/withdraws/request';
  static const String auctionPayCommission =
      '/api/v3/seller/auction/commission/pay/';
  static const String auctionUploadTrackingUri =
      '/api/v3/seller/auction/products/tracking-url/';
  static const String auctionAddressUpdateUri =
      '/api/v3/seller/auction/products/address-update';
  static const String auctionPaymentStatusUri =
      '/api/v3/seller/auction/products/payment-status/';
  static const String auctionDeliveryStatusUpdateUri =
      '/api/v3/seller/auction/products/delivery-status/';
  static const String auctionGenerateInvoiceUri =
      '/api/v3/seller/auction/products/generate-invoice/';
  static const String auctionCancelUri =
      '/api/v3/seller/auction/products/cancel/';
  static const String auctionSalesReportUri =
      '/api/v3/seller/auction/sales-report';
  static const String auctionTransactionHistoryUri =
      '/api/v3/seller/auction/transaction-history';
  static const String courierConfigUri = '/api/v3/seller/courier/config';
  static const String courierProvidersUri = '/api/v3/seller/courier/providers';
  static const String courierDispatchUri = '/api/v3/seller/courier/dispatch';
  static const String courierReviseUri = '/api/v3/seller/courier/revise';
  static const String courierEstimateUri = '/api/v3/seller/courier/estimate';
  static const String courierTrackUri = '/api/v3/seller/courier/track/';
  static const String courierLocationStoresUri =
      '/api/v3/seller/courier/locations/stores';
  static const String courierLocationCitiesUri =
      '/api/v3/seller/courier/locations/cities';
  static const String courierLocationZonesUri =
      '/api/v3/seller/courier/locations/zones/';
  static const String courierLocationAreasUri =
      '/api/v3/seller/courier/locations/areas/';
  static const String auctionNotificationList =
      '/api/v3/seller/auction/notifications/list';
  static const String auctionMarkNotificationSeen =
      '/api/v3/seller/auction/notifications/seen';
  static const String productTitleGenerate =
      '/api/v3/seller/product/title-auto-fill';
  static const String productDescriptionGenerate =
      '/api/v3/seller/product/description-auto-fill';
  static const String productGeneralSetupGenerate =
      '/api/v3/seller/product/general-setup-auto-fill';
  static const String productPricingGenerate =
      '/api/v3/seller/product/price-others-auto-fill';
  static const String productVariationSetupGenerate =
      '/api/v3/seller/product/variation-setup-auto-fill';
  static const String productSeoSectionGenerate =
      '/api/v3/seller/product/seo-section-auto-fill';
  static const String productGenerateTitleGenerate =
      '/api/v3/seller/product/generate-title-suggestions';
  static const String productAnalyzeImageAutoGenerate =
      '/api/v3/seller/product/analyze-image-auto-fill';
  static const String generateLimitCheck =
      '/api/v3/seller/product/generate-limit-check';
  static const String auctionTitleAutoFill =
      '/api/v3/seller/auction/product/title-auto-fill';
  static const String auctionDescriptionAutoFill =
      '/api/v3/seller/auction/product/description-auto-fill';
  static const String auctionGeneralSetupAutoFill =
      '/api/v3/seller/auction/product/general-setup-auto-fill';
  static const String auctionShippingPolicyAutoFill =
      '/api/v3/seller/auction/product/shipping-policy-auto-fill';
  static const String auctionInfoAutoFill =
      '/api/v3/seller/auction/product/auction-info-auto-fill';
  static const String auctionSeoSectionAutoFill =
      '/api/v3/seller/auction/product/seo-section-auto-fill';
  static const String auctionAnalyzeImageAutoFill =
      '/api/v3/seller/auction/product/analyze-image-auto-fill';
  static const String auctionSetupAutoFill =
      '/api/v3/seller/auction/product/setup-auto-fill';
  static const String auctionGenerateTitleSuggestions =
      '/api/v3/seller/auction/product/generate-title-suggestions';
  static const String geocodeUri = '/api/v1/mapapi/geocode-api';
  static const String searchLocationUri =
      '/api/v1/mapapi/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/mapapi/place-api-details';
  static const String setCurrentLanguageUri = '/api/v3/seller/language-change';
  static const String deleteProductImage =
      '/api/v3/seller/products/delete-images';
  static const String getProductImage =
      '/api/v3/seller/products/get-product-images/';
  static const String deleteProductPreview =
      '/api/v3/seller/products/delete-preview-file';
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String processing = 'processing';
  static const String processed = 'processed';
  static const String delivered = 'delivered';
  static const String failed = 'failed';
  static const String returned = 'returned';
  static const String cancelled = 'canceled';
  static const String outForDelivery = 'out_for_delivery';
  static const String approved = 'approved';
  static const String rejected = 'rejected';
  static const String done = 'refunded';
  static const String orderWise = 'order_wise';
  static const String productWise = 'product_wise';
  static const String categoryWise = 'category_wise';
  static const String currency = 'currency';
  static const String shippingType = 'shipping_type';
  static const String cartList = 'cart_list';
  static const String userAddress = 'user_address';
  static const String userPassword = 'user_password';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String topic = 'six_valley_seller';
  static const String maintenanceModeTopic = 'maintenance_mode_start_vendor';
  static const String userEmail = 'user_email';
  static const String showCookies = 'cookies';
  static const String bluetoothMacAddress = 'bluetooth_mac_address';
  static const double maxSizeOfASingleFile = 10;
  static const double maxLimitOfTotalFileSent = 5;
  static const double maxLimitOfFileSentINConversation = 25;
  static const int fileImageMaxLimit = 2;
  // User app specific constants
  static const String slogan = 'E-Commerce Marketplace';
  static const LocalCachesTypeEnum cachesType = LocalCachesTypeEnum.all;
  static const String googleServerClientId = 'client_id here';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String categoriesUri = '/api/v1/categories';
  static const String brandProductUri = '/api/v1/brands/products/';
  static const String categoryProductUri = '/api/v1/categories/products/';
  static const String registrationUri = '/api/v1/auth/register';
  static const String logOut = '/api/v1/auth/logout';
  static const String latestProductUri =
      '/api/v1/products/latest?guest_id=1&limit=10&&offset=';
  static const String newArrivalProductUri =
      '/api/v1/products/new-arrival?guest_id=1&limit=10&&offset=';
  static const String topProductUri =
      '/api/v1/products/top-rated?guest_id=1&limit=10&&offset=';
  static const String bestSellingProductUri =
      '/api/v1/products/best-sellings?guest_id=1&limit=10&offset=';
  static const String discountedProductUri =
      '/api/v1/products/discounted-product?guest_id=1&limit=10&&offset=';
  static const String featuredProductUri =
      '/api/v1/products/featured?guest_id=1&limit=10&&offset=';
  static const String homeCategoryProductUri =
      '/api/v1/products/home-categories?guest_id=1';
  static const String productDetailsUri = '/api/v1/products/details/';
  static const String searchUri = '/api/v1/products/filter';
  static const String getSuggestionProductName =
      '/api/v1/products/suggestion-product?guest_id=1&name=';
  static const String addWishListUri =
      '/api/v1/customer/wish-list/add?product_id=';
  static const String removeWishListUri =
      '/api/v1/customer/wish-list/remove?product_id=';
  static const String updateProfileUri = '/api/v1/customer/update-profile';
  static const String customerUri = '/api/v1/customer/info';
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String removeAddressUri = '/api/v1/customer/address';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String getWishListUri = '/api/v1/customer/wish-list';
  static const String supportTicketUri =
      '/api/v1/customer/support-ticket/create';
  static const String getBannerList = '/api/v1/banners';
  static const String relatedProductUri = '/api/v1/products/related-products/';
  static const String orderUri = '/api/v1/customer/order/list?limit=10&offset=';
  static const String orderDetailsUri =
      '/api/v1/customer/order/details?order_id=';
  static const String orderPlaceUri = '/api/v1/customer/order/place';
  static const String sellerList = '/api/v1/seller/list/';
  static const String trackingUri = '/api/v1/order/track?order_id=';
  static const String forgetPasswordUri = '/api/v1/auth/forgot-password';
  static const String getSupportTicketUri =
      '/api/v1/customer/support-ticket/get';
  static const String supportTicketConversationUri =
      '/api/v1/customer/support-ticket/conv/';
  static const String supportTicketReplyUri =
      '/api/v1/customer/support-ticket/reply/';
  static const String closeSupportTicketUri =
      '/api/v1/customer/support-ticket/close/';
  static const String submitReviewUri = '/api/v1/products/reviews/submit';
  static const String getOrderWiseReview = '/api/v1/products/review/';
  static const String updateOrderWiseReview = '/api/v1/products/review/update';
  static const String deleteOrderWiseReviewImage =
      '/api/v1/products/review/delete-image';
  static const String flashDealUri = '/api/v1/flash-deals';
  static const String featuredDealUri = '/api/v1/deals/featured';
  static const String flashDealProductUri = '/api/v1/flash-deals/products/';
  static const String counterUri = '/api/v1/products/counter/';
  static const String socialLinkUri = '/api/v1/products/social-share-link/';
  static const String shippingUri = '/api/v1/products/shipping-methods';
  static const String getShippingMethod = '/api/v1/shipping-method/by-seller';
  static const String couponUri = '/api/v1/coupon/apply?code=';
  static const String chatInfoUri = '/api/v1/customer/chat/list/';
  static const String searchChat = '/api/v1/customer/chat/search/';
  static const String notificationUri = '/api/v1/notifications';
  static const String seenNotificationUri = '/api/v1/notifications/seen';
  static const String getCartDataUri = '/api/v1/cart';
  static const String addToCartUri = '/api/v1/cart/add';
  static const String updateCartQuantityUri = '/api/v1/cart/update';
  static const String removeFromCartUri = '/api/v1/cart/remove';
  static const String chooseShippingMethod =
      '/api/v1/shipping-method/choose-for-order';
  static const String chosenShippingMethod = '/api/v1/shipping-method/chosen';
  static const String sendOtpToPhone = '/api/v1/auth/check-phone';
  static const String resendPhoneOtpUri = '/api/v1/auth/resend-otp-check-phone';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String socialLoginUri = '/api/v1/auth/social-customer-login';
  static const String sendOtpToEmail = '/api/v1/auth/check-email';
  static const String resendEmailOtpUri = '/api/v1/auth/resend-otp-check-email';
  static const String verifyEmailUri = '/api/v1/auth/verify-email';
  static const String refundRequestUri = '/api/v1/customer/order/refund-store';
  static const String refundRequestPreReqUri = '/api/v1/customer/order/refund';
  static const String refundResultUri = '/api/v1/customer/order/refund-details';
  static const String cancelOrderUri = '/api/v1/order/cancel-order';
  static const String getSelectedShippingTypeUri =
      '/api/v1/shipping-method/check-shipping-type';
  static const String walletTransactionUri = '/api/v1/customer/wallet/list';
  static const String loyaltyPointUri = '/api/v1/customer/loyalty/list';
  static const String loyaltyPointConvert =
      '/api/v1/customer/loyalty/loyalty-exchange-currency';
  static const String deleteCustomerAccount = '/api/v1/customer/account-delete';
  static const String deliveryRestrictedCountryList =
      '/api/v1/customer/get-restricted-country-list';
  static const String deliveryRestrictedZipList =
      '/api/v1/customer/get-restricted-zip-list';
  static const String getOrderFromOrderId =
      '/api/v1/customer/order/get-order-by-id?order_id=';
  static const String offlinePayment =
      '/api/v1/customer/order/place-by-offline-payment';
  static const String walletPayment = '/api/v1/customer/order/place-by-wallet';
  static const String couponListApi = '/api/v1/coupon/list?limit=100&offset=';
  static const String sellerWiseCouponListApi = '/api/v1/coupons/';
  static const String sellerWiseBestSellingProduct = '/api/v1/seller/';
  static const String offlinePaymentList =
      '/api/v1/customer/order/offline-payment-method-list';
  static const String sellerWiseCategoryList = '/api/v1/categories?shop_slug=';
  static const String sellerWiseBrandList = '/api/v1/brands?shop_slug=';
  static const String getDigitalAuthorList =
      '/api/v1/products/digital-author-list?guest_id=1';
  static const String getDigitalPublishingHouse =
      '/api/v1/products/digital-publishing-house-list?guest_id=1';
  static const String verifyProfileInfo = '/api/v1/auth/verify-profile-info';
  static const String productRestockRequest =
      '/api/v1/cart/product-restock-request';
  static const String productRestockList =
      '/api/v1/customer/restock-requests/list?';
  static const String productRestockDelete =
      '/api/v1/customer/restock-requests/delete';
  static const String clearanceAllProductUri =
      '/api/v1/products/clearance-sale';
  static const String clearanceShopProductUri = '/api/v1/seller/';
  static const String clearanceShopSearchProductUri = '/api/v1/seller/';
  static const String getDeliveryManReview =
      '/api/v1/customer/order/deliveryman-review?order_id=';
  static const String submitDeliveryManReview =
      '/api/v1/customer/order/deliveryman-review/update?order_id=';
  static const String mergeGuestCart = '/api/v1/cart/get-merge-guest-cart';
  static const String orderDetailsTrack =
      '/api/v1/order/track-order-details?order_id=';
  static const String updateAddressUri = '/api/v1/customer/address/update';
  static const String distanceMatrixUri = '/api/v1/mapapi/distance-api';
  static const String chatWithDeliveryMan = '/api/v1/mapapi/distance-api';
  static const String getGuestIdUri = '/api/v1/get-guest-id';
  static const String mostDemandedProduct =
      '/api/v1/products/most-demanded-product?guest_id=1';
  static const String shopAgainFromRecentStore =
      '/api/v1/products/shop-again-product';
  static const String findWhatYouNeed = '/api/v1/categories/find-what-you-need';
  static const String addFundToWallet = '/api/v1/add-to-fund';
  static const String reorder = '/api/v1/customer/order/again';
  static const String walletBonusList = '/api/v1/customer/wallet/bonus-list';
  static const String moreStore = '/api/v1/seller/more';
  static const String justForYou = '/api/v1/products/just-for-you?guest_id=1';
  static const String mostSearching = '/api/v1/products/most-searching';
  static const String contactUsUri = '/api/v1/contact-us';
  static const String availableCoupon = '/api/v1/coupon/applicable-list';
  static const String downloadDigitalProduct =
      '/api/v1/customer/order/digital-product-download/';
  static const String otpVResendForDigitalProduct =
      '/api/v1/customer/order/digital-product-download-otp-resend';
  static const String otpVerificationForDigitalProduct =
      '/api/v1/customer/order/digital-product-download-otp-verify';
  static const String selectCartItemsUri = '/api/v1/cart/select-cart-items';
  static const String checkEmailUri = '/api/v1/auth/check-email';
  static const String checkPhoneUri = '/api/v1/auth/check-phone?phone=';
  static const String registerWithOtp = '/api/v1/auth/registration-with-otp';
  static const String verifyTokenUri = '/api/v1/auth/verify-token';
  static const String existingAccountCheck =
      '/api/v1/auth/existing-account-check';
  static const String referralAmountUri =
      '/api/v1/cart/get-referral-discount-redeem';
  static const String duePaymentByCodUri =
      '/api/v1/edit-order/due-payment-by-cod';
  static const String duePaymentByDigitalPayment =
      '/api/v1/edit-order/due-payment-by-digital-payment';
  static const String duePaymentByWallet =
      '/api/v1/edit-order/due-payment-by-wallet';
  static const String duePaymentByOfflinePayment =
      '/api/v1/edit-order/due-payment-by-offline-payment';
  static const String getCompareList = '/api/v1/customer/compare/list';
  static const String addToCompareList =
      '/api/v1/customer/compare/product-store';
  static const String removeAllFromCompareList =
      '/api/v1/customer/compare/clear-all';
  static const String replaceFromCompareList =
      '/api/v1/customer/compare/product-replace';
  static const String registerWithSocialMedia =
      '/api/v1/auth/registration-with-social-media';
  static const String auctionAddonPurchaseUrl = '';
  static const String createAuctionProductsUri =
      '/api/v1/customer/auction/products/store';
  static const String updateAuctionProductsUri =
      '/api/v1/customer/auction/products/update';
  static const String creatorAuctionProductDetailsUri =
      '/api/v1/customer/auction/products/details';
  static const String customerAuctionProductRequestListUri =
      '/api/v1/customer/auction/products/pending-approval-list';
  static const String customerAuctionProductListUri =
      '/api/v1/customer/auction/products/list';
  static const String customerMyBidList =
      '/api/v1/customer/auction/products/my-bid-list';
  static const String auctionCategoriesUri =
      '/api/v1/customer/auction/categories';
  static const String auctionCategoryProductListUri =
      '/api/v1/customer/auction/products/category';
  static const String customerAuctionProductDeleteUri =
      '/api/v1/customer/auction/products/delete/';
  static const String customerAuctionProductCancelUri =
      '/api/v1/customer/auction/products/cancel/';
  static const String auctionPopularTags =
      '/api/v1/customer/auction/products/popular-tags';
  static const String getAuctionSuggestionProductName =
      '/api/v1/customer/auction/products/suggestion-product';
  static const String participationAuctionProductDetailsUri =
      '/api/v1/customer/auction/products/overview/';
  static const String auctionEntryFeeUri =
      '/api/v1/customer/auction/entry-fees/store';
  static const String auctionPlaceBidUri =
      '/api/v1/customer/auction/bids/place';
  static const String auctionWithdrawBidUri =
      '/api/v1/customer/auction/bids/withdraw';
  static const String auctionRollbackBidUri =
      '/api/v1/customer/auction/bids/rollback';
  static const String auctionBidListUri = '/api/v1/customer/auction/bids/list/';
  static const String auctionCreatorBidListUri =
      '/api/v1/customer/auction/my-auction/bids/';
  static const String auctionSaveUri =
      '/api/v1/customer/auction/saved-products/store';
  static const String auctionClaimUri = '/api/v1/customer/auction/claims/store';
  static const String auctionSocialShareUri =
      '/api/v1/customer/auction/products/social-share-link/';
  static const String auctionSaveListUri =
      '/api/v1/customer/auction/saved-products/list';
  static const String auctionRecentViewsUri =
      '/api/v1/customer/auction/recent-views/list';
  static const String auctionDeliveryStatusUri =
      '/api/v1/customer/auction/products/delivery-status/';
  static const String userCreatedAuctionList =
      '/api/v1/customer/auction/products/my-auction-list';
  static const String withdrawMethodListUri =
      '/api/v1/customer/auction/withdraw-methods/list';
  static const String auctionCommissionPayUri =
      '/api/v1/customer/auction/commission/pay/';
  static const String auctionWithdrawStoreOrUpdateUri =
      '/api/v1/customer/auction/withdraws/store-or-update';
  static const String auctionRelaunchUri =
      '/api/v1/customer/auction/products/relaunch/';
  static const String auctionGenerateLimitCheck =
      '/api/v1/customer/auction/product/generate-limit-check';
  static const String aiShoppingSearch = '/api/v1/customer/ai-shopping/search';
  static const String aiShoppingImageSearch =
      '/api/v1/customer/ai-shopping/image-search';
  static const String aiShoppingLimitCheck =
      '/api/v1/customer/ai-shopping/generate-limit-check';
  static const String aiShoppingUploadImage =
      '/api/v1/ai/assistant/upload-image';
  static const String aiShoppingSessions = '/api/v1/ai/assistant/sessions';
  static const String auctionDashboardSummaryUri =
      '/api/v1/customer/auction/dashboard-summary';
  static const String auctionNotificationListUri =
      '/api/v1/customer/auction/notifications/list';
  static const String auctionNotificationSeenUri =
      '/api/v1/customer/auction/notifications/seen';
  static const String homeAddress = 'home_address';
  static const String searchProductName = 'search_product';
  static const String auctionSearchProductName = 'auction_search_product_name';
  static const String officeAddress = 'office_address';
  static const String guestMode = 'guest_mode';
  static const String intro = 'intro';
  static const String userLogData = 'user_log_data';
  static const double minFilter = 0;
  static const double maxFilter = 1000000;
  static const String appleLoginEmail = 'apple_login_email';
  static const String guestCartId = 'guest_cart_id';
  static const String demoTopic = 'demo_reset';
  static const int flashDealProductShowLimit = 13;
  static const int flashDealProductShowMaximumLimit = 99;
  static const int auctionProductProductShowLimit = 13;
  static const int auctionProductShowMaximumLimit = 99;
  static const List<String> videoExtensions = [
    'mp4',
    'mkv',
    'avi',
    'mov',
    'wmv',
    'flv',
    'webm',
    'mpeg',
    'mpg',
    'm4v',
    '3gp',
    'ogv'
  ];
  static const List<String> imageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'gif',
    'webp'
  ];
  static const List<String> documentExtensions = [
    'doc',
    'docx',
    'txt',
    'csv',
    'xls',
    'xlsx',
    'pdf'
  ];
  static const List<String> disallowedExtensions = [
    'php',
    'php3',
    'php4',
    'php5',
    'php7',
    'php8',
    'phtml',
    'phar',
    'asp',
    'aspx',
    'jsp',
    'cgi',
    'pl',
    'py',
    'rb',
    'js',
    'mjs',
    'html',
    'htm',
    'xhtml',
    'sh',
    'bash',
    'bat',
    'cmd',
    'ps1',
    'zsh',
    'ksh',
    'exe',
    'dll',
    'so',
    'bin',
    'msi',
    'app',
    'java',
    'class',
    'jar',
    '7z',
    'gz',
    'bz2',
    'xz',
    'env',
    'ini',
    'conf',
    'config',
    'yml',
    'yaml',
    'log',
    'sql',
    'db',
    'bak',
    'old',
    'swp',
    'tmp'
  ];
  static const List<String> filterTypeList = ['all', 'debit', 'credit'];
  static const List<String> loyaltyEarnTypeList = [
    'order_place',
    'register',
    'referred'
  ];
  static const List<String> walletEarnTypeList = [
    'add_fund',
    'refund',
    'loyalty_point',
    'order_place'
  ];
  static const String guestId = 'guestId';
  static const String token = 'token';
  static const String languageName = 'languageName';
  static const String countryCode = 'countryCode';
  static const String languageCode = 'languageCode';
  static const List<String> sellerAuctionTypes = [];
  static const List<String> customerAuctionTypes = [];
  static const String otherSetupGuidelineList = 'otherSetupGuidelineList';
  static const String paymentInfoGuidelineList = 'paymentInfoGuidelineList';
  static const String inHouseShopGuidelineList = 'inHouseShopGuidelineList';
  static const String orderDetailsId = 'orderDetailsId';
  static const String refundId = 'refundId';

  // Image paths fallback in AppConstants
  static const String reviewList = 'assets/image/review_list.png';
  static const String orderTrack = 'assets/image/order_track.png';
  static const String digitalPayment = 'assets/image/digital_payment.png';
  static const String imageUrl = 'assets/image/image_url.png';
  static const String auctionGenerateInvoice =
      'assets/image/auction_generate_invoice.png';
  static const String dealOfTheDay = 'assets/image/deal_of_the_day.png';
}
