import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/customer/splash/controllers/splash_controller.dart' as c_splash;
import 'package:multishop_tchad/features/vendor/splash/controllers/splash_controller.dart' as v_splash;
import 'package:provider/provider.dart';

class _CurrencyConfig {
  final String currencyModel;
  final String currencySymbolPosition;
  final String symbol;
  final double exchangeRate;
  final double usdExchangeRate;
  final int decimalPointSettings;

  const _CurrencyConfig({
    required this.currencyModel,
    required this.currencySymbolPosition,
    required this.symbol,
    required this.exchangeRate,
    required this.usdExchangeRate,
    required this.decimalPointSettings,
  });
}

class PriceConverter {
  static _CurrencyConfig _getConfig(BuildContext context) {
    // 1. Try Vendor SplashController first if in vendor context
    try {
      final vSplash = Provider.of<v_splash.SplashController>(context, listen: false);
      if (vSplash.configModel != null) {
        final config = vSplash.configModel;
        final myCurr = vSplash.myCurrency ?? vSplash.defaultCurrency;
        final double rate = (myCurr?.exchangeRate != null && myCurr!.exchangeRate! > 0) ? myCurr.exchangeRate! : 1.0;
        final double usdRate = (vSplash.usdCurrency?.exchangeRate != null && vSplash.usdCurrency!.exchangeRate! > 0) ? vSplash.usdCurrency!.exchangeRate! : 1.0;
        return _CurrencyConfig(
          currencyModel: config?.currencyModel ?? 'single_currency',
          currencySymbolPosition: config?.currencySymbolPosition ?? 'right',
          symbol: myCurr?.symbol ?? 'FCFA',
          exchangeRate: rate,
          usdExchangeRate: usdRate,
          decimalPointSettings: config?.decimalPointSetting ?? config?.decimalPointSettings ?? 0,
        );
      }
    } catch (_) {}

    // 2. Try Customer SplashController
    try {
      final cSplash = Provider.of<c_splash.SplashController>(context, listen: false);
      if (cSplash.configModel != null) {
        final config = cSplash.configModel;
        final myCurr = cSplash.myCurrency ?? cSplash.defaultCurrency;
        final double rate = (myCurr?.exchangeRate != null && myCurr!.exchangeRate! > 0) ? myCurr.exchangeRate! : 1.0;
        final double usdRate = (cSplash.usdCurrency?.exchangeRate != null && cSplash.usdCurrency!.exchangeRate! > 0) ? cSplash.usdCurrency!.exchangeRate! : 1.0;
        return _CurrencyConfig(
          currencyModel: config?.currencyModel ?? 'single_currency',
          currencySymbolPosition: config?.currencySymbolPosition ?? 'right',
          symbol: myCurr?.symbol ?? 'FCFA',
          exchangeRate: rate,
          usdExchangeRate: usdRate,
          decimalPointSettings: config?.decimalPointSettings ?? 0,
        );
      }
    } catch (_) {}

    // 3. Safe fallback defaults for MultiShop Tchad
    return const _CurrencyConfig(
      currencyModel: 'single_currency',
      currencySymbolPosition: 'right',
      symbol: 'FCFA',
      exchangeRate: 1.0,
      usdExchangeRate: 1.0,
      decimalPointSettings: 0,
    );
  }

  static String convertPrice(BuildContext context, double? price, {double? discount, String? discountType}) {
    if (price == null) return '0';
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    final config = _getConfig(context);
    bool singleCurrency = config.currencyModel == 'single_currency';
    bool inRight = config.currencySymbolPosition == 'right';

    try {
      double finalPrice = singleCurrency
          ? price
          : (price * config.exchangeRate * (1 / config.usdExchangeRate));

      String formattedPrice = finalPrice
          .toStringAsFixed(config.decimalPointSettings)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');

      return inRight ? '$formattedPrice ${config.symbol}' : '${config.symbol} $formattedPrice';
    } catch (_) {
      return price.toStringAsFixed(config.decimalPointSettings);
    }
  }

  static double? convertWithDiscount(BuildContext context, double? price, double? discount, String? discountType) {
    if (price == null) return 0.0;
    if (discountType == 'amount' || discountType == 'flat') {
      price = price - (discount ?? 0.0);
    } else if (discountType == 'percent' || discountType == 'percentage') {
      price = price - (((discount ?? 0.0) / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount' || type == 'flat') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent' || type == 'percentage') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, double? price, double? discount, String? discountType) {
    final config = _getConfig(context);
    if (discountType == 'percent' || discountType == 'percentage') {
      return '-${discount?.toStringAsFixed(config.decimalPointSettings) ?? '0'} %';
    }
    return '-${convertPrice(context, discount)}';
  }

  static String getUnitCurrency(BuildContext context, double? price) {
    if (price == null) return '0';
    final config = _getConfig(context);
    bool singleCurrency = config.currencyModel == 'single_currency';
    bool inRight = config.currencySymbolPosition == 'right';

    double finalPrice = singleCurrency
        ? price
        : (price * config.exchangeRate * (1 / config.usdExchangeRate));

    String formattedPrice = finalPrice
        .toStringAsFixed(config.decimalPointSettings)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');

    return inRight ? '$formattedPrice ${config.symbol}' : '${config.symbol} $formattedPrice';
  }

  static String convertPriceWithoutSymbol(BuildContext context, double? price, {double? discount, String? discountType}) {
    if (price == null) return '0';
    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    final config = _getConfig(context);
    bool singleCurrency = config.currencyModel == 'single_currency';

    double finalPrice = singleCurrency
        ? price
        : (price * config.exchangeRate * (1 / config.usdExchangeRate));

    return finalPrice.toStringAsFixed(config.decimalPointSettings);
  }

  static double toLocalDouble(BuildContext context, double price) {
    final config = _getConfig(context);
    if (config.currencyModel == 'single_currency') return price;
    return config.usdExchangeRate != 0 ? price * config.exchangeRate / config.usdExchangeRate : price;
  }

  static String longToShortPrice(double amount, {bool withDecimalPoint = true}) {
    int decimalPoint = withDecimalPoint ? 2 : 0;

    if (amount.abs() >= 1e12) {
      return '${(amount / 1e12).toStringAsFixed(decimalPoint)}T';
    } else if (amount.abs() >= 1e9) {
      return '${(amount / 1e9).toStringAsFixed(decimalPoint)}B';
    } else if (amount.abs() >= 1e6) {
      return '${(amount / 1e6).toStringAsFixed(decimalPoint)}M';
    } else if (amount.abs() >= 1e3) {
      return '${(amount / 1e3).toStringAsFixed(decimalPoint)}K';
    } else {
      return amount.toStringAsFixed(decimalPoint);
    }
  }

  // Vendor app compatibility method
  static String showCurrencyCode(BuildContext context, String amount) {
    final config = _getConfig(context);
    bool inRight = config.currencySymbolPosition == 'right';
    return inRight ? '$amount ${config.symbol}' : '${config.symbol} $amount';
  }

  static double systemCurrencyToDefaultCurrency(double price, BuildContext context) {
    final config = _getConfig(context);
    if (config.currencyModel == 'single_currency') {
      return price;
    } else {
      return config.exchangeRate != 0 ? price / config.exchangeRate : price;
    }
  }

  static double convertAmount(double amount, BuildContext context) {
    final config = _getConfig(context);
    if (config.currencyModel == 'single_currency') return amount;
    return double.parse((amount * config.exchangeRate * (1 / config.usdExchangeRate)).toStringAsFixed(config.decimalPointSettings));
  }

  static String discountCalculationWithOutSymbol(BuildContext context, double price, double discount, String? discountType, {bool? convertCurrency}) {
    return (price - discount).toString();
  }

  static String reverseConvertPriceWithoutSymbol(BuildContext context, double? price, {bool? removeDecimalPoint}) {
    return price?.toString() ?? '0.0';
  }

  static String discountCalculation(BuildContext context, double price, double discount, String? discountType) {
    return (price - discount).toString();
  }
}
