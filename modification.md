# Journal des Modifications — MultiShop Tchad

> Ce fichier répertorie **l'ensemble des modifications** apportées au projet (Backend Admin Laravel et Application Mobile Flutter).
> Chaque entrée contient : la date, les fichiers modifiés, le type de changement, la description et le détail technique.
> Objectif : pouvoir auditer et rejouer toutes ces modifications sur une nouvelle base propre sans perte d'information.

---

## 1. Modifications Backend / Projet Admin Laravel (`C:\laragon\www\admin`)

### [28/09/2026] — Correction 405 sur Order Place & setState sur CustomTextFieldWidget
- **Fichier(s)** :
  - `routes/rest_api/v1/api.php`
  - `app/Http/Controllers/RestAPI/v1/OrderController.php`
  - `lib/core/widgets/base/custom_textfield_widget.dart`
  - `lib/features/customer/checkout/domain/repositories/checkout_repository.dart`
- **Type** : FIX
- **Description** :
  - **405 Method Not Allowed sur `/api/v1/customer/order/place`** : La route Laravel était configurée uniquement en `Route::get('place', ...)`. L'application Flutter envoyant un `postMultipart` (pour la photo de la porte et les données d'adresse), la requête était rejetée avec une erreur 405. La route a été mise à jour avec `Route::match(['get', 'post'], 'place', ...)` et `OrderController@updateTchadFields` gère désormais `door_photo` et `door_photo_url`.
  - **Exception `setState() called after dispose()` dans `CustomTextFieldWidget`** : L'écouteur de focus (`focusNode.addListener`) attachait une fermeture anonyme sans détachement dans `dispose()` ni vérification de `mounted`. Remplacement par une méthode nommée `_onFocusChanged`, suppression dans `dispose()`, et vérification de `mounted` dans `showAndCloseTooltip()` et `_toggle()`.

---

### [27/09/2026] — Négociation de Prix par Produit dans le Panier (CDC 3.4.7)
- **Fichier(s)** :
  - `database/migrations/2026_09_27_000001_add_cart_id_to_price_reduction_requests_table.php`
  - `app/Models/PriceReductionRequest.php`
  - `app/Services/PriceReductionService.php`
  - `app/Events/ReductionRequestedEvent.php`
  - `app/Http/Controllers/RestAPI/v1/PriceReductionController.php`
  - `app/Http/Controllers/RestAPI/v1/CartController.php`
  - `app/Http/Controllers/RestAPI/v3/seller/ReductionController.php`
  - `routes/rest_api/v1/api.php`
  - `routes/rest_api/v3/seller.php`
- **Type** : NEW | ADAPT
- **Description** : Permet au client de négocier le prix de chaque article individuellement dans son panier avant de commander, et au vendeur d'accepter, refuser ou contre-proposer.
- **Détails techniques** :
  - Migration : ajout des colonnes `cart_id` et `product_id` (unsigned big integer nullable) sur `price_reduction_requests`, et passage de `order_id` en nullable.
  - Modèle `PriceReductionRequest` : ajout de `cart_id` et `product_id` dans `$fillable`, ajout des relations `cart()` et `product()`.
  - Service `PriceReductionService` :
    - Ajout de la méthode `createCartRequest(Cart $cart, User $customer, $requestedReduction)` pour initialiser la négociation d'une ligne de panier avec proposition de prix calculée et limitation à 1 négociation active par article.
    - Mise à jour de `acceptRequest()` : applique automatiquement le montant négocié en réduction directe sur le panier client (`$cart->discount = requested_reduction`).
    - Mise à jour de `respondToCounterOffer()` : applique automatiquement le montant de la contre-offre au panier (`$cart->discount = counter_offer_amount`) si acceptée par le client.
  - Événement `ReductionRequestedEvent` : constructeur adapté avec paramètre `?Order $order = null` pour supporter les négociations panier hors-commande.
  - Contrôleur `PriceReductionController` (v1) :
    - `createCartRequest(Request $request)` : validation et création de la demande pour une ligne de panier.
    - `getCartNegotiations(Request $request)` : récupération des demandes de négociation actives du panier.
    - `respondToCounterOffer(Request $request, $requestId)` : validation de la réponse client (`accept: bool`).
  - Contrôleur `CartController` (v1 `getCartList`) :
    - Injection des métadonnées de négociation pour chaque article : `negotiation_status`, `negotiation_reduction`, `counter_offer_amount`, `negotiation_id`, `negotiation_round`, `negotiated_price`.
  - Contrôleur Vendeur `ReductionController` (v3 `getRequests`) : eager-loading des relations `customer`, `product`, `order` pour afficher les détails complets des négociations panier et commandes.
  - Routes :
    - `POST /api/v1/customer/cart/negotiate`
    - `GET /api/v1/customer/cart/negotiations`
    - `PUT /api/v1/customer/cart/negotiations/{requestId}/respond`

---

### [24/09/2026] — Système de Réduction de Prix par Paliers (CDC 3.4.7 initial)
- **Fichier(s)** :
  - `database/migrations/2026_09_09_000002_create_price_reduction_requests_table.php`
  - `database/migrations/2026_09_09_000005_create_reduction_tiers_table.php`
  - `app/Models/PriceReductionRequest.php`
  - `app/Services/PriceReductionService.php`
  - `app/Http/Controllers/RestAPI/v1/PriceReductionController.php`
  - `app/Http/Controllers/RestAPI/v3/seller/ReductionController.php`
- **Type** : NEW
- **Description** : Implémentation du système de réduction par paliers fixes autorisés (250, 500, 1000, 1500, 2000, 2500, 3000, 3500 FCFA), avec limitation à 2 rounds maximum.
- **Détails techniques** :
  - Endpoints client pour consulter les paliers (`/api/v1/reduction-tiers`) et négocier sur commande existante.
  - Endpoints vendeur (`/api/v3/seller/reduction-requests`, `accept`, `refuse`, `counter-offer`).

---

### [24/09/2026] — Annulation de Commande et Frais Wallet (1 000 FCFA)
- **Fichier(s)** :
  - `app/Http/Controllers/RestAPI/v1/OrderController.php` (méthode `order_cancel`)
  - `app/Utils/CustomerManager.php`
- **Type** : ADAPT
- **Description** : Application de la règle métier d'annulation du cahier des charges : déduction automatique de 1000 FCFA du portefeuille si la commande n'est plus au statut `pending`.
- **Détails techniques** :
  - Vérification du statut de la commande (rejet si `delivered`, `canceled`, `returned`, `failed`).
  - Si le statut n'est pas `pending` : vérification que le solde wallet >= 1000 FCFA. Si insuffisant, rejet de l'annulation.
  - Déduction des 1000 FCFA via `CustomerManager::create_wallet_transaction` avec le type de transaction `order_cancellation`.
  - Prise en charge du type `order_cancellation` comme débit dans `CustomerManager.php`.

---

### [24/09/2026] — Checkout Tchad : Adresse Complète et Photo de Porte
- **Fichier(s)** :
  - `app/Http/Controllers/RestAPI/v1/OrderController.php`
- **Type** : ADAPT
- **Description** : Prise en charge et enregistrement des champs d'adresse tchadiens et de la photo de porte pour les livraisons.
- **Détails techniques** :
  - Ajout de la méthode `updateTchadFields()` :
    - Récupère et stocke `delivery_quarter`, `delivery_street`, `delivery_description`, `door_latitude`, `door_longitude`.
    - Gère l'upload de l'image `door_photo` via `ImageManager` et renseigne `door_photo_url`.
  - Intégration de l'appel dans `place_order`, `placeOrderByOfflinePayment`, et `placeOrderByWallet`.

---

### [24/09/2026] — Authentification & Inscription : Numéro National d'Identification (NNI)
- **Fichier(s)** :
  - `app/Http/Controllers/RestAPI/v2/seller/auth/RegisterController.php`
  - `app/Http/Controllers/RestAPI/v3/seller/auth/RegisterController.php`
  - `app/Http/Controllers/RestAPI/v1/auth/CustomerAPIAuthController.php`
  - Tables `nni_records`, `users`, `sellers`
- **Type** : ADAPT
- **Description** : Prise en charge obligatoire et validation d'unicité du champ NNI pour l'inscription des clients et des vendeurs tchadiens.

---

### [24/09/2026] — Paiements Mobiles Tchad (Airtel Money & Moov Money)
- **Fichier(s)** :
  - `app/Http/Controllers/RestAPI/v1/MobilePaymentController.php`
  - `routes/rest_api/v1/api.php`
- **Type** : NEW | ADAPT
- **Description** : Endpoints dédiés aux paiements Airtel Money et Moov Money avec validation du numéro de téléphone de paiement (`payment_phone`).

---

### [Historique Initial] — Configuration & Stabilisation Backend Admin
- **Fichier(s)** :
  - `resources/views/installation/step3.blade.php`
  - `app/Traits/InstallationTrail.php`
  - `app/Http/Controllers/InstallController.php`
  - `app/Http/Controllers/Admin/Auth/LoginController.php`
  - `resources/views/admin-views/auth/login.blade.php`
  - `app/Providers/AppServiceProvider.php`
  - `.env`
- **Type** : FIX
- **Description** :
  - Rendre le mot de passe de base de données facultatif lors de l'installation locale (Laragon/MySQL).
  - Correction de l'erreur 500 liée à la méthode `cleanupEnvFileContext`.
  - Désactivation du reCaptcha sur le login Admin.
  - Forçage de `APP_URL` (`URL::forceRootUrl`) pour éviter les redirections localhost.
  - Correction des redirections de sous-dossier `/admin`.

---

## 2. Modifications Application Flutter (`multishop_tchad/flutter_app`)

### [27/09/2026] — Négociation Panier par Produit & Paliers
- **Fichier(s)** :
  - `lib/features/customer/cart/domain/models/cart_model.dart`
  - `lib/features/customer/cart/domain/repositories/cart_repository_interface.dart`
  - `lib/features/customer/cart/domain/repositories/cart_repository.dart`
  - `lib/features/customer/cart/domain/services/cart_service_interface.dart`
  - `lib/features/customer/cart/domain/services/cart_service.dart`
  - `lib/features/customer/cart/controllers/cart_controller.dart`
  - `lib/features/customer/cart/widgets/cart_widget.dart`
  - `lib/features/customer/cart/widgets/cart_product_negotiation_bottom_sheet.dart`
  - `lib/core/constants/app_constants.dart`
  - `assets/language/fr.json`, `assets/language/ar.json`, `assets/language/en.json`
- **Type** : NEW | ADAPT
- **Description** : Intégration complète de la négociation directe par produit dans le panier :
  - `CartModel` : propriétés `negotiationStatus`, `negotiationReduction`, `negotiatedPrice`, `counterOfferAmount`, `negotiationId`, `negotiationRound`.
  - `CartProductNegotiationBottomSheet` : bottom sheet avec choix parmi les 8 paliers autorisés (250 à 3500 FCFA), calcul dynamique en direct (prix unitaire, réduction, nouveau prix, économie totale).
  - `CartWidget` : badge d'état interactif (`pending`, `accepted`, `counter_offer`, `refused`) avec boutons d'action instantanée [Accepter] / [Refuser].
  - Localisation complète en français, arabe et anglais.

---

### [27/09/2026] — Correctifs UI Panier, Thèmes & Sélecteur de Langue
- **Fichier(s)** :
  - `lib/core/theme/controllers/theme_controller.dart`, `light_theme.dart`, `dark_theme.dart`
  - `lib/features/customer/cart/widgets/cart_bottom_sheet_widget.dart`
  - `lib/features/customer/cart/screens/cart_screen.dart`
  - `lib/features/customer/setting/widgets/select_language_bottom_sheet_widget.dart`
  - `lib/features/vendor/settings/widgets/language_widget.dart`
  - `lib/core/constants/images.dart`, `app_constants.dart`
- **Type** : FIX
- **Description** :
  - Suppression de la surcouche noire transparente sur la barre "Add to cart" des détails de produit via harmonisation des couleurs de thèmes.
  - Correction du crash de désactivation d'ancêtre (`deactivated widget ancestor lookup`) sur `CartBottomSheetWidgetState.dispose`.
  - Correction du crash Null check operator sur l'asset du drapeau français (`Images.fr`, `fr.png`).
  - Élimination des débordements RenderFlex sur la barre inférieure du panier et suppression des boutons de test parasites.

---

### [24/09/2026] — Checkout Tchad, Photo de Porte, Annulation & Paiements Mobiles
- **Fichier(s)** :
  - `lib/features/customer/checkout/widgets/shipping_details_widget.dart`
  - `lib/features/customer/checkout/controllers/checkout_controller.dart`
  - `lib/features/customer/checkout/domain/repositories/checkout_repository.dart`
  - `lib/features/customer/checkout/screens/door_photo_screen.dart`
  - `lib/features/customer/order_details/widgets/cancel_order_dialog_widget.dart`
  - `lib/features/customer/order_details/widgets/cancel_and_support_center_widget.dart`
  - `lib/features/customer/order/widgets/order_widget.dart`
  - `lib/features/customer/checkout/widgets/choose_payment_widget.dart`
  - `lib/features/vault/wallet/widgets/add_fund_dialogue_widget.dart`
  - `lib/features/vendor/order/domain/models/order_model.dart`
  - `lib/features/vendor/order_details/widgets/shipping_and_biilling_widget.dart`
- **Type** : NEW | ADAPT
- **Description** :
  - Intégration des champs d'adresse (Quartier, Rue, Indications) et de la capture GPS / photo de porte dans le checkout client et affichage dans la vue vendeur.
  - Dialogue de confirmation d'annulation avec avertissement des frais de 1000 FCFA.
  - Saisie du numéro de téléphone de paiement pour Airtel Money et Moov Money.

---

### [28/09/2026] — Remplacement de la marque "6am/6Valley" & Résolution du 401 sur Chat Vendeur
- **Fichier(s) Backend** :
  - Base de données (`business_settings`, `shops`) : mise à jour de `company_name` (`MultiShop Tchad`), `company_email` (`contact@multishop-tchad.com`), `company_copyright_text` (`Copyright MultiShop Tchad © 2026`), `shop_address` (`N'Djamena, Tchad`).
  - `app/Traits/PdfGenerator.php` : sécurisation de la génération du pied de page des factures PDF pour garantir l'utilisation exclusive des coordonnées de MultiShop Tchad.
  - `resources/themes/default/web-views/order/invoice.blade.php`, `resources/views/admin-views/order/invoice.blade.php`, `resources/views/vendor-views/order/invoice.blade.php` : affichage du nom de la compagnie MultiShop Tchad et de l'adresse en en-tête de reçu même si aucun logo personnalisé n'a été configuré.
- **Fichier(s) Mobile Flutter** :
  - `lib/core/constants/app_constants.dart` :
    - Remplacement de `companyName = '6Valley'` par `companyName = 'MultiShop Tchad'`.
    - Rétablissement des routes de chat client : `/api/v1/customer/chat/get-messages/`, `send-message/`, `seen-message/`.
    - Séparation des routes de chat vendeur (`vendorCartUri`, `vendorChatSearchUri`, `vendorMessageUri`, `vendorSendMessageUri`, `vendorSeenMessageUri`).
  - `lib/features/vendor/chat/domain/repositories/chat_repository.dart` : utilisation des constantes dédiées au vendeur (`AppConstants.vendor*`).
  - `lib/features/vendor/utill/app_constants.dart` : mise à jour de `companyName = 'MultiShop Tchad'`.
  - `lib/features/vault/ai_shopping/screens/ai_shopping_screen.dart` : mise à jour du message d'accueil de l'assistant d'achat pour MultiShop Tchad.
- **Type** : FIX | BRANDING
- **Description** :
  - Élimination définitive des mentions résiduelles "6amTech" et "6Valley" sur le reçu / facture de commande et dans l'application mobile au profit de MultiShop Tchad.
  - Correction de l'erreur `401 Unauthorized` sur `/admin/api/v3/seller/messages/get-message/seller/0` : le repository client appelait à tort une route protégée par le middleware vendeur suite à une collision de constantes. Les routes client et vendeur sont désormais clairement dissociées.
### [29/09/2026] — Résolution du ProviderNotFoundException (SplashController Vendeur)
- **Fichier(s) Mobile Flutter** :
  - `lib/core/di/di_container.dart` :
    - Réactivation et enregistrement de `v_splash_controller.SplashController`, `v_theme_controller.ThemeController`, `v_localization_controller.LocalizationController`, `v_bottom_menu_controller.BottomMenuController`, et `v_tutorial_controller.TutorialController` dans GetIt (`sl`).
  - `lib/core/di/provider_setup.dart` :
    - Enregistrement des 5 controllers vendeurs dans `MultiProvider` (`getProviders()`).
  - `lib/features/auth/screens/login_screen.dart` :
    - Appel de `await Provider.of<v_splash.SplashController>(Get.context!, listen: false).initConfig()` lors de la connexion en mode vendeur avant la redirection vers `DashboardScreen`.
  - `lib/features/vendor/auth/screens/login_screen.dart` :
    - Sécurisation null-safe sur `configModel?.sellerRegistration == "1"`.
    - Appel explicite de `initConfig()` avant la transition vers `DashboardScreen`.
- **Type** : FIX
- **Description** :
  - Résolution du crash `ProviderNotFoundException (Error: Could not find the correct Provider<SplashController> above this Navigator Widget...)` survenu lors de la tentative de connexion en tant que vendeur. Les contrôleurs nécessaires à l'espace vendeur sont désormais injectés et instanciés proprement dans le widget tree Flutter.

### [29/09/2026] — Sécurisation Null-Safety (configModel et deliveryManList) dans l'Espace Vendeur
- **Fichier(s) Mobile Flutter** :
  - `lib/features/vendor/home/screens/home_page_screen.dart` :
    - Remplacement de l'accès forcé `configModel!.shippingMethod` par un `Consumer<SplashController>` réactif et null-safe sur `configModel?.shippingMethod`.
    - Déclenchement automatique de `initConfig()` dans `_loadData()` si `configModel == null`.
  - `lib/features/vendor/dashboard/screens/dashboard_screen.dart` :
    - Déclenchement automatique de `initConfig()` dans `initState()` si non encore initialisé.
  - `lib/features/vendor/delivery_man/widgets/top_delivery_man_view_widget.dart` :
    - Sécurisation du test sur `deliveryManList` (`(deliveryManList != null && deliveryManList.isNotEmpty)`).
  - `lib/features/vendor/auth/screens/registration_screen.dart` :
    - Sécurisation null-safe sur `configModel?.countryCode` et `configModel?.activeTheme`.
  - `lib/features/vendor/product_details/widgets/product_details_widget.dart` :
    - Sécurisation null-safe sur `configModel?.languageList`.
- **Type** : FIX
- **Description** :
  - Résolution de l'exception `_TypeError (Null check operator used on a null value)` provoquée par `configModel!.shippingMethod` dans `home_page_screen.dart` lorsque les données de configuration réseau sont en cours de chargement asynchrone ou non encore instanciées.

### [30/09/2026] — Dé-Branding Complet (6Valley & 6amTech -> MultiShop Tchad)
- **Base de données MySQL (`multishop_tchad`)** :
  - `social_medias` : remplacement des URLs de démo `dev.6amtech.com` par `#`.
  - `oauth_clients` : mise à jour du client Passport de `6amtech` vers `MultiShop Tchad`.
- **Backend Admin Laravel (`C:\laragon\www\admin`)** :
  - `.env` & `.env.example` : `APP_NAME="MultiShop Tchad"`, `CONTAINER_NAME_PREFIX=multishop-tchad`, `DB_DATABASE=multishop_tchad`.
  - `config/app.php` & `config/builder.php` : noms d'application et de plateforme par défaut mis à jour vers `MultiShop Tchad` et `multishop_tchad`.
  - `app/Traits/PushNotificationTrait.php` & `app/Utils/settings.php` : topics Firebase mis à jour de `sixvalley` vers `multishop_tchad`.
  - `app/Http/Controllers/UpdateController.php` & `app/Traits/InstallationTrail.php` : mise à jour du nom par défaut de l'application vers `MultiShop Tchad`.
  - Vues et gabarits (`resources/views/`) :
    - Suppression des bandeaux démo et liens d'achat Codecanyon dans `layouts/admin/partials/_header.blade.php`, `layouts/admin/partials/v2/_body.blade.php` et `layouts/vendor/partials/v2/_body.blade.php`.
    - Neutralisation des liens Codecanyon et des blogs externes 6amtech dans `system-setup/software-update.blade.php`, `seo-settings/error-logs.blade.php`, `seo-settings/robots-meta-content-view.blade.php`, `seo-settings/web-master-tool.blade.php`, et `third-party/recaptcha-index.blade.php`.
    - Thèmes web (`resources/themes/`) : remplacement des cookies `6valley_cookie_consent` par `multishop_cookie_consent`, mise à jour des balises `alt` et des en-têtes CSS/JS de métadonnées.
    - Écrans d'installation & mise à jour (`installation/` et `update/`) : remplacement de "6valley Software" par "MultiShop Tchad Software".
    - `table.blade.php` et `vat-tax/` : élimination de 76 occurrences d'URLs d'exemples statiques `Backend-6Valley-eCommerce-CMS` au profit d'URLs relatives dynamiques.
    - Fichiers de langues backend (`resources/lang/`) : neutralisation des clés et libellés démo dans `en`, `es`, `bd`, `in`, `sa`.
- **Projet Mobile Flutter (`multishop_tchad/flutter_app`)** :
  - Fichiers de langues (`assets/language/ar.json`, `en.json`, `fr.json`) : remplacement de toutes les mentions de "6Valley" et "6valley Auction" par "MultiShop Tchad" et "MultiShop Tchad Enchères".
  - Configurations iOS (`ios/Runner.xcodeproj/project.pbxproj`, `ios/Runner/Info.plist`) : nom de l'application iOS défini à `MultiShop Tchad` et mise à jour du domaine universal links vers `multishop-tchad.com`.
  - Notifications (`lib/core/helpers/notification_helper.dart`) : channel id de livraison mis à jour vers `multishop_delivery`.
  - Assets (`images.dart`) : renommage de `6valley_logo.svg` en `multishop_logo.svg` et mise à jour de la constante `logoSvg`.
  - Nettoyage : suppression des scripts temporaires de patch à la racine du projet.
- **Type** : REFACTOR | BRANDING
- **Description** :
  - Remplacement exhaustif de toutes les références à la marque d'origine (6Valley, 6amTech, 6amdev) à travers l'ensemble des couches de l'écosystème : base de données, application mobile Flutter, backend administratif et thèmes web.

### [30/09/2026] — Résolution des Anomalies & Blocages de l'Audit des 5 Fonctionnalités
- **Backend Admin Laravel (`C:\laragon\www\admin`)** :
  - `app/Http/Controllers/RestAPI/v3/seller/ReductionController.php` :
    - Remplacement de `$request->user()->id` par `$request->seller->id` dans `getRequests()`, `accept()`, `refuse()`, et `counterOffer()`. Élimination du crash fatal 500 (`Call to a member function id() on null`) causé par le fait que le middleware `seller_api_auth` injecte `$request->seller` et non `$request->user()`.
  - `app/Services/PriceReductionService.php` :
    - Mise à jour de `acceptRequest()` et `respondToCounterOffer()` pour recalculer et déduire automatiquement le montant de la réduction sur `orders.order_amount` et incrémenter `orders.discount_amount` lorsque la réduction validée concerne une commande (`order_id`).
  - `app/Http/Controllers/RestAPI/v3/seller/ProductController.php` :
    - Sécurisation de la méthode `delete()` : vérification de l'existence du produit (retour 404 au lieu d'une exception PHP sur `$product['images']`) et vérification stricte de propriété (`$product->added_by == 'seller' && $product->user_id == $seller->id`, retour 403 en cas de tentative non autorisée).
  - `app/Http/Controllers/RestAPI/v1/OrderController.php` :
    - Dans `updateTchadFields()`, synchronisation automatique des champs spécifiques Tchad (`delivery_quarter`, `delivery_street`, `delivery_description`, `door_photo_url`, `door_latitude`, `door_longitude`) à la fois dans les colonnes dédiées de `orders` et dans l'objet JSON `orders.shipping_address_data`.
- **Application Mobile Flutter (`multishop_tchad/flutter_app`)** :
  - `lib/core/di/datasource/remote/dio/dio_client.dart` :
    - Initialisation du token avec fallback : `sharedPreferences.getString(AppConstants.userLoginToken) ?? sharedPreferences.getString(AppConstants.token)`. Évite les erreurs 401 Unauthorized après redémarrage ou reconnexion vendeur.
  - `lib/features/vendor/auth/domain/repositories/auth_repository.dart` :
    - Dans `saveUserToken()`, persistance du token sous les deux clés `AppConstants.token` et `AppConstants.userLoginToken`, et synchronisation immédiate avec `dioClient!.updateHeader(token, null)`.
    - Nettoyage des deux clés de token dans `clearSharedData()`.
  - `lib/features/vendor/order/domain/models/order_model.dart` :
    - Ajout de getters directs sur `Order` pour les coordonnées et champs Tchad (`deliveryQuarter`, `deliveryStreet`, `deliveryDescription`, `doorPhoto`, `doorLatitude`, `doorLongitude`).
    - Dans `Order.fromJson()`, mapping dynamique des champs d'adresse Tchad de la racine du JSON vers `_shippingAddressData`, garantissant l'affichage de l'adresse et de la navigation GPS dans l'espace vendeur.
- **Type** : FIX | SECURITY | ARCHITECTURE
- **Description** :
  - Résolution des points de rupture fonctionnelle et de sécurité identifiés lors de l'audit de simulation des flux Vendeur, Commande, Produit, Réduction et Messagerie.

---

### [01/10/2026] — Résolution Exhaustive des Anomalies & Inspection Page par Page (Flutter & Laravel)
- **Backend Admin Laravel (`C:\laragon\www\admin`)** :
  - `app/Http/Controllers/RestAPI/v1/OrderController.php` :
    - Règle d'annulation Tchad : suppression du blocage HTTP 403 `insufficient_wallet_balance_for_cancellation_fee` qui piégeait le client. Débit systématique via transaction wallet `order_cancellation` et enregistrement de `cancellation_fee = 1000` sur la commande.
  - `app/Http/Controllers/RestAPI/v1/auth/CustomerAPIAuthController.php` :
    - Prise en charge du champ `nni` (validation d'unicité `unique:nni_records,nni_number` et persistance DB) dans les méthodes `registrationWithOTP` et `registrationWithSocialMedia`, complétant ainsi l'inscription email classique.
- **Application Mobile Flutter (`multishop_tchad/flutter_app`)** :
  - `lib/features/customer/checkout/screens/checkout_screen.dart` :
    - Initialisation de `double _couponDiscount = 0.0;` et `double _referralDiscount = 0.0;`.
    - Restauration de `late bool _billingAddress;` et initialisation de `late SplashController splashController;` dans `initState()`.
    - Élimination des opérateurs `!` non sécurisés qui causaient un crash immédiat `_TypeError (Null check operator used on a null value)` lors de la validation par Portefeuille ou paiement hors ligne.
  - `lib/features/customer/cart/screens/cart_screen.dart` & `cart_widget.dart` :
    - Remplacement des accès `cartList[i].isChecked!` et `cartModel!.isChecked!` par `isChecked ?? false`.
    - Remplacement des accès non sécurisés `price!`, `discount!` et `shippingCost!` par des fallbacks sécurisés (`?? 0`).
  - `lib/features/auth/screens/login_screen.dart` :
    - Fallback sécurisé sur `ConfigModel` avec `CustomerLogin` par défaut pour éviter les crashs au démarrage si la configuration réseau est différée.
    - Préfixage sécurisé de l'indicatif téléphonique avec fallback Tchad (`countryCode ?? '+235'`).
  - `lib/features/auth/screens/forget_password_screen.dart` :
    - Déplacement de l'accès à `SplashController` hors de l'instanciation de champ vers `initState()` et `build()`.
    - Sécurisation du `_countryCode` et du `configModel`.
  - `lib/features/auth/screens/mobile_verify_screen.dart` :
    - Correction de la troncature du numéro de téléphone lors de la concaténation de l'indicatif.
    - Rétablissement de la navigation vers `VerificationScreen` après l'envoi réussi de l'OTP.
  - `lib/features/vendor/order_details/screens/order_details_screen.dart` :
    - Sécurisation de tous les montants et remises calculés (`discountAmount`, `shippingCost`, `itemsPrice`, `extraDiscount`) pour éviter un crash d'affichage sur les commandes vendeur.
  - `lib/features/vendor/pos/screens/pos_screen.dart` :
    - Remplacement de `double.tryParse(...)!` par `(double.tryParse(...) ?? 0.0)`.
  - `lib/features/vendor/shop/screens/shop_update_screen.dart` :
    - Déplacement de l'affectation des contrôleurs de texte de `build()` vers `initState()` afin d'éviter la réinitialisation intempestive du texte et du curseur à chaque frappe.
  - `lib/features/vendor/menu/widgets/menu_widget.dart` :
    - Intégration du module de remboursement vendeur orphelin (`RefundScreen`) sous forme d'élément de menu navigable.
  - `lib/features/vendor/emergency_contract/screens/emergency_contact_screen.dart` :
    - Correction de la double closure `() => () {}` sur le bouton de recherche et implémentation de `onRefresh`.
  - `lib/features/shared/chat/screens/chat_screen.dart` :
    - Suppression du `SingleChildScrollView` parent en conflit pour éliminer l'assertion fatale `ScrollController attached to multiple scroll views`.
    - Implémentation de `dispose()` pour `scrollController` et `inputMessageController`.
  - `lib/features/vault/support/screens/support_conversation_screen.dart` :
    - Remplacement de `DateTime.parse(createdAt!)` par `DateTime.tryParse`.
  - `lib/features/customer/checkout/screens/door_photo_screen.dart` :
    - Rendu du callback `onSave` optionnel et sécurisé.
    - Internationalisation des libellés (Photo de la porte, Valider, Prendre une photo) avec `getTranslated`.
  - `lib/features/customer/address/domain/models/address_model.dart` :
    - Ajout et mapping des attributs Tchad (`quarter`, `street`, `deliveryDescription`, `doorPhotoUrl`, `doorLatitude`, `doorLongitude`, `nni`).
  - `lib/core/helpers/route_helper.dart` :
    - Sécurisation de l'extraction des paramètres (`state.extra`) sur la route `/door-photo`.
  - Nettoyage dette technique :
    - Suppression des fichiers morts/doublons `lib/core/router/app_router.dart` et `lib/features/customer/screens/splash_screen.dart`.
    - Nettoyage des imports orphelins dans `lib/main.dart`.
- **Validation** :
  - `dart analyze` sur l'ensemble des 18 fichiers modifiés : **0 erreur, 0 avertissement** (`No issues found!`).
  - `php -l` sur les contrôleurs Laravel modifiés : **Syntaxe 100% valide**.

---

### [01/10/2026] — Restauration des Logos, Synchronisation Assets & Fix getColorList Null Crash
- **Problèmes Identifiés** :
  1. `Null check operator used on a null value` dans `SplashController.getColorList` (`splash_controller.dart:145:40`) provoqué par un appel direct non-attendu dans `_HomePageScreenState._loadData` avant que `initConfig()` n'ait terminé son chargement.
  2. Crash `Unable to load asset: "assets/image/home.png"` dû à une faute de frappe historique (`assets/image/` sans `s` au lieu de `assets/images/`) dans `images.dart` et `app_constants.dart`.
  3. Disparition des logos vendeur et icônes d'interface : 132 images issues de l'application Vendor (`logo_with_app_name.png`, `logo_white.png`, etc.) étaient manquantes dans `assets/images/` de l'application unifiée.
  4. Inversion dans le parsing de `ConfigModel` entre `companyLogo` et `companyCoverImage`.
- **Corrections Appliquées** :
  - `lib/features/vendor/splash/controllers/splash_controller.dart` :
    - Sécurisation de `getColorList()` pour retourner une liste vide si `_configModel?.colors` est nul au lieu de crasher.
    - Sécurisation de `initConfig()`, `getCurrencyData()`, `setCurrency()`, `setShippingType()`.
  - `lib/features/vendor/home/screens/home_page_screen.dart` :
    - Enchaînement asynchrone `initConfig().then((_) => getColorList())`.
  - `lib/core/constants/images.dart` & `app_constants.dart` :
    - Remplacement des 28 occurrences erronées de `assets/image/` par le chemin valide `assets/images/`.
  - `assets/images/` :
    - Copie et synchronisation intégrale de l'ensemble des 132 assets vendor manquants (dont `logo_with_app_name.png` et `logo_white.png`).
  - `lib/features/customer/splash/domain/models/config_model.dart` :
    - Rétablissement du mapping correct de `companyLogo` vers `json['company_logo']` et `companyCoverImage` vers `json['company_cover_image']`.
  - `lib/features/customer/home/screens/home_screens.dart` :
    - Null-safety sur la bannière d'annonce (`configModel?.announcement?.status`).
- **Validation** :
  - `dart analyze` : **No issues found!**


