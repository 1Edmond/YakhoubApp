/// Clés des fonctionnalités hors cahier des charges, masquées par défaut.
class VaultFeature {
  static const String auction = 'auction';
  static const String aiShopping = 'ai_shopping';
  static const String deal = 'deal';
  static const String wallet = 'wallet';
  static const String loyalty = 'loyalty';
  static const String referAndEarn = 'refer_and_earn';
  static const String support = 'support';
  static const String blog = 'blog';
  static const String compare = 'compare';
  static const String coupon = 'coupon';
  static const String clearanceSale = 'clearance_sale';
  static const String restock = 'restock';
  static const String reorder = 'reorder';
  static const String refund = 'refund';
  static const String review = 'review';
  static const String wishlist = 'wishlist';
  static const String contactUs = 'contact_us';

  // Moyens de paiement hors CDC (CDC 3.4.4 : Airtel Money / Moov Money uniquement)
  static const String codPayment = 'cod_payment';
  static const String walletPayment = 'wallet_payment';
  static const String digitalPayment = 'digital_payment';
  static const String offlinePayment = 'offline_payment';

  static const List<String> all = [
    auction, aiShopping, deal, wallet, loyalty, referAndEarn, support, blog, compare, coupon,
    clearanceSale, restock, reorder, refund, review, wishlist, contactUs,
    codPayment, walletPayment, digitalPayment, offlinePayment,
  ];

  /// Routes du router (RouterHelper) rattachées à une fonctionnalité du vault.
  static const Map<String, String> _routes = {
    '/ai-shopping': aiShopping,
    '/blog': blog,
    '/clearance-sale-all-product': clearanceSale,
    '/clearance-sale-shop-product': clearanceSale,
    '/compare-product': compare,
    '/contact-us': contactUs,
    '/coupon-list': coupon,
    '/featured-deal': deal,
    '/flash-deal': deal,
    '/loyalty-point': loyalty,
    '/refer-and-earn': referAndEarn,
    '/referral-login': referAndEarn,
    '/restock-list': restock,
    '/support-ticket': support,
    '/support-conversation': support,
    '/review': review,
    '/wallet': wallet,
    '/add-fund-wallet': wallet,
    '/wish-list': wishlist,
    '/offline-payment-screen': offlinePayment,
    '/order-offline-payment-screen': offlinePayment,
  };

  /// Retourne la fonctionnalité vault protégeant [location], ou null si la route est publique.
  static String? featureForLocation(String location) {
    if (location.contains('auction')) return auction;
    for (final e in _routes.entries) {
      if (location == e.key || location.startsWith('${e.key}/') || location.startsWith('${e.key}?')) {
        return e.value;
      }
    }
    return null;
  }
}
