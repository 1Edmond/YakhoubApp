# Plan d'Implémentation - Résolution des Anomalies des 5 Fonctionnalités Clés

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Corriger les anomalies critiques et blocages identifiés lors de l'audit de simulation des 5 fonctionnalités (Authentification vendeur, Commandes Tchad, CRUD Produits vendeur, Demandes de réduction par palier, Messagerie).

**Architecture:** 
- Côté Backend Laravel (`C:\laragon\www\admin`) : Correction des contrôleurs `ReductionController` (utilisation de `$request->seller`), recalcul de la réduction de prix dans `PriceReductionService`, et sécurisation de la suppression dans `ProductController`.
- Côté Mobile Flutter (`d:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app`) : Harmonisation des clés de token d'authentification dans `DioClient`/`AuthRepository`, mapping des champs d'adresse Tchad dans `OrderModel`, et affichage de la photo de porte et coordonnées GPS dans `ShippingAndBillingWidget`.

**Tech Stack:** Laravel 11 / PHP 8.2+, Flutter 3.27+ / Dart, Dio, Provider, MySQL 8.4.

**Spec:** [simulation_audit_plan.md](file:///C:/Users/fried/.gemini/antigravity/brain/f22b8e71-dde7-4974-abbf-ef3efdfa966c/simulation_audit_plan.md)

---

### Task 1: Correction du Contrôleur de Réduction Vendeur (Laravel)

**Files:**
- Modify: `C:\laragon\www\admin\app\Http\Controllers\RestAPI\v3\seller\ReductionController.php:20-48`

**Interfaces:**
- Consumes: `$request->seller` fourni par `SellerApiAuthMiddleware`
- Produces: JSON response avec les requêtes de réduction et résultats accept/refuse/counter-offer

- [ ] **Step 1: Remplacer `$request->user()->id` par `$request->seller->id`**
Dans `ReductionController.php`, modifier les méthodes `getRequests`, `accept`, `refuse`, et `counterOffer` pour extraire `$seller = $request->seller;` et utiliser `$seller->id`.
- [ ] **Step 2: Vérifier la syntaxe PHP**
Exécuter : `php -l C:\laragon\www\admin\app\Http\Controllers\RestAPI\v3\seller\ReductionController.php`
Attendu : `No syntax errors detected`

---

### Task 2: Déduction du Montant de Réduction sur la Commande (Laravel)

**Files:**
- Modify: `C:\laragon\www\admin\app\Services\PriceReductionService.php:75-125`

**Interfaces:**
- Consumes: `PriceReductionRequest $request`
- Produces: Mise à jour de `orders.order_amount` et `orders.discount_amount` lors de l'acceptation

- [ ] **Step 1: Modifier `acceptRequest` et `respondToCounterOffer`**
Si `$request->order_id` est défini, récupérer `Order::find($request->order_id)` et déduire le montant validé de `order_amount` tout en l'ajoutant à `discount_amount`. Sauvegarder la commande.
- [ ] **Step 2: Vérifier la syntaxe PHP**
Exécuter : `php -l C:\laragon\www\admin\app\Services\PriceReductionService.php`
Attendu : `No syntax errors detected`

---

### Task 3: Sécurisation et Robustesse de la Suppression Produit (Laravel)

**Files:**
- Modify: `C:\laragon\www\admin\app\Http\Controllers\RestAPI\v3\seller\ProductController.php:1748-1763`

**Interfaces:**
- Consumes: `$request->seller`, `$id`
- Produces: JSON response 200 en cas de succès, 404 si non trouvé, 403 si le produit n'appartient pas au vendeur

- [ ] **Step 1: Ajouter les gardes d'autorisation et vérification null**
Dans `ProductController::delete`, vérifier `$product = Product::find($id);` :
- Si `!$product`, retourner `response()->json(['message' => translate('Product_not_found')], 404);`
- Si `$product->added_by != 'seller' || $product->user_id != $request->seller->id`, retourner `response()->json(['message' => translate('Unauthorized_action')], 403);`
- Vérifier `if (!empty($product['images']))` avant d'itérer sur `json_decode`.
- [ ] **Step 2: Vérifier la syntaxe PHP**
Exécuter : `php -l C:\laragon\www\admin\app\Http\Controllers\RestAPI\v3\seller\ProductController.php`
Attendu : `No syntax errors detected`

---

### Task 4: Harmonisation de la Persistance du Token Vendeur (Flutter)

**Files:**
- Modify: `d:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vendor\auth\domain\repositories\auth_repository.dart:109-142`
- Modify: `d:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\core\di\datasource\remote\dio\dio_client.dart:23-28`

**Interfaces:**
- Consumes: `AppConstants.userLoginToken`, `AppConstants.token`
- Produces: Header `Authorization: Bearer <token>` toujours synchronisé après reconnexion ou restart

- [ ] **Step 1: Sauvegarder le token vendeur également dans `AppConstants.userLoginToken`**
Dans `Vendor AuthRepository.saveUserToken(token)`, écrire également `sharedPreferences.setString(AppConstants.userLoginToken, token)` et appeler `dioClient.updateHeader(token, null)`.
- [ ] **Step 2: Dans `DioClient`, fallback de token**
Lors de l'initialisation de `DioClient`, si `userLoginToken` est null ou vide, vérifier si `token` existe dans `sharedPreferences` et l'affecter.

---

### Task 5: Mapping & Affichage des Données d'Adresse Tchad (Flutter)

**Files:**
- Modify: `d:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vendor\order\domain\models\order_model.dart:200-240`
- Modify: `d:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vendor\order_details\widgets\shipping_and_biilling_widget.dart`

**Interfaces:**
- Consumes: JSON retourné par `GET /api/v3/seller/orders/{id}`
- Produces: Champs `deliveryQuarter`, `deliveryStreet`, `doorPhoto`, `doorLatitude`, `doorLongitude` renseignés sur `orderModel` et affichés avec bouton "Naviguer"

- [ ] **Step 1: Mettre à jour `OrderModel.fromJson`**
Dans `OrderModel.fromJson`, extraire `deliveryQuarter = json['delivery_quarter']`, `deliveryStreet = json['delivery_street']`, `deliveryDescription = json['delivery_description']`, `doorPhoto = json['door_photo_url'] ?? json['door_photo']`, `doorLatitude = json['door_latitude']?.toString()`, `doorLongitude = json['door_longitude']?.toString()`.
- [ ] **Step 2: Intégrer l'affichage dans `shipping_and_biilling_widget.dart`**
Ajouter une section "Adresse de livraison (Tchad)" affichant le quartier, la rue, la description, la photo de la porte miniature cliquable, et un bouton "Naviguer vers le client" avec `url_launcher` ouvrant Google Maps si les coordonnées sont disponibles.

---

### Task 6: Vérification et Documentation

**Files:**
- Modify: `d:\Projets\Yakhoub\opencode\multishop_tchad\modification.md`

- [ ] **Step 1: Exécuter `dart analyze`**
S'assurer qu'aucune erreur ou avertissement bloquant n'a été introduit.
- [ ] **Step 2: Mettre à jour `modification.md`**
Renseigner précisément tous les correctifs appliqués.
