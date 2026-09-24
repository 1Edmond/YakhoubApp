// import 'package:multishop_tchad/core/constants/app_constants.dart';

class MockData {
  static const Map<String, dynamic> loginResponse = {
    "token": "mock_guest_token_123456",
    "is_phone_verified": 1,
    "is_email_verified": 1
  };

  static const Map<String, dynamic> userInfo = {
    "id": 1,
    "name": "Guest User",
    "f_name": "Guest",
    "l_name": "User",
    "phone": "00000000",
    "email": "guest@multishop.td",
    "image": "def.png",
    "is_active": 1,
    "wallet_balance": 150000.0,
    "loyalty_point": 500
  };

  static const Map<String, dynamic> vendorInfo = {
    "id": 2,
    "f_name": "Guest",
    "l_name": "Vendor",
    "phone": "11111111",
    "email": "vendor@multishop.td",
    "image": "def.png",
    "status": "approved",
    "wallet": {
      "total_earning": 250000.0,
      "withdrawn": 0.0,
      "pending_withdraw": 0.0,
      "collected_cash": 0.0
    }
  };

  static const Map<String, dynamic> configResponse = {
    "company_name": "MultiShop Tchad",
    "currency_symbol": "FCFA",
    "currency_symbol_position": "right",
    "base_urls": {
      "product_image_url": "https://multishop.td/storage/app/public/product",
      "customer_image_url": "https://multishop.td/storage/app/public/profile",
      "banner_image_url": "https://multishop.td/storage/app/public/banner",
      "category_image_url": "https://multishop.td/storage/app/public/category",
      "review_image_url": "https://multishop.td/storage/app/public/review",
      "seller_image_url": "https://multishop.td/storage/app/public/seller",
      "shop_image_url": "https://multishop.td/storage/app/public/shop",
      "notification_image_url": "https://multishop.td/storage/app/public/notification"
    },
    "static_urls": {
      "contact_us": "https://multishop.td/contact-us",
      "brands": "https://multishop.td/brands",
      "categories": "https://multishop.td/categories",
      "customer_account": "https://multishop.td/user-account"
    },
    "currency_model": [
      {
        "id": 1,
        "name": "CFA Franc",
        "symbol": "FCFA",
        "code": "XAF",
        "exchange_rate": "1.000000",
        "status": 1
      }
    ],
        "payment_methods": [
      {
        "key_name": "airtel_money",
        "additional_datas": {
          "gateway_title": "Airtel Money",
          "gateway_image": "airtel_logo.png"
        }
      },
      {
        "key_name": "moov_money",
        "additional_datas": {
          "gateway_title": "Moov Money",
          "gateway_image": "moov_logo.png"
        }
      }
    ],
    "digital_payment": true,
    "forget_password_verification": "email",
    "system_default_currency": 1
  };
}
