# Plan de Correction des Modules Restants - MultiShop Tchad

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Corriger les anomalies critiques et blocages identifiés lors de l'audit complet des fonctionnalités restantes du backend Laravel et de l'application Flutter MultiShop Tchad.

**Architecture:** Corriger la logique métier d'annulation avec frais de 1 000 FCFA côté Laravel et Flutter, harmoniser le NNI sur tous les parcours d'inscription, sécuriser le rejet de remboursement vendeur avec note obligatoire, et aligner les flux de support client et de portefeuille.

**Tech Stack:** Laravel 10/11 (PHP 8.2), Flutter 3.x (Dart), Provider, DioClient, MySQL 8.4.

**Spec:** [simulation_audit_plan_part2.md](file:///C:/Users/fried/.gemini/antigravity/brain/f22b8e71-dde7-4974-abbf-ef3efdfa966c/simulation_audit_plan_part2.md)

## Global Constraints

- Respect strict du Cahier des Charges Tchad (CDC 3.4.4 pour les frais d'annulation de 1 000 FCFA, CDC 3.1.2 pour le NNI).
- Ne jamais casser la compatibilité avec l'API existante.
- Conserver l'intégrité de la base de données et l'auditabilité financière du portefeuille.

## Review Focus

1. Annulation de commande lorsque le portefeuille client a un solde inférieur à 1 000 FCFA (ne pas bloquer l'annulation indéfiniment).
2. Vérification que la déduction du portefeuille en FCFA ne subit pas de conversion de devise erronée.
3. Vérification de la note obligatoire lors du rejet d'une demande de remboursement par le vendeur.
4. Transmission correcte des pièces jointes `image[]` lors de la création d'un ticket de support.
5. Inscription via OTP / Réseaux sociaux : enregistrement ou invitation à compléter le NNI.

---

### Task 1: Résolution du Blocage de l'Annulation de Commande (Frais 1 000 FCFA)

**Files:**
- Modify: `C:\laragon\www\admin\app\Http\Controllers\RestAPI\v1\OrderController.php:101-118`
- Modify: `C:\laragon\www\admin\app\Utils\CustomerManager.php:68-80`
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\customer\order_details\widgets\cancel_order_dialog_widget.dart:72-90`

**Interfaces:**
- Consumes: `POST /api/v1/customer/order/cancel` avec `order_id`
- Produces: HTTP 200 avec message de confirmation et montant des frais déduits/enregistrés.

- [ ] **Step 1: Modifier `OrderController::order_cancel` dans Laravel**
  Permettre l'annulation même si `wallet_balance < 1000` en autorisant un solde débiteur négatif ou un solde résiduel enregistré avec avertissement, plutôt que de rejeter en HTTP 403 bloquant.
  
- [ ] **Step 2: Adapter `CustomerManager::create_wallet_transaction` pour supporter le débit d'annulation**
  Permettre au solde de passer en débit et logger explicitement `order_cancellation` avec référence `order_id`.

- [ ] **Step 3: Mettre à jour `cancel_order_dialog_widget.dart` dans Flutter**
  Interpréter correctement la réponse backend, afficher un snackbar d'avertissement si des frais de 1 000 FCFA ont été prélevés, et fermer la boîte de dialogue proprement.

- [ ] **Step 4: Vérifier la compilation et le fonctionnement**
  Vérifier la syntaxe PHP et la compilation Flutter (`flutter analyze`).

- [ ] **Step 5: Commit**
  `git commit -m "fix(order): resolve cancellation fee 403 block for low wallet balance"`

---

### Task 2: Harmonisation du NNI sur les Inscriptions Rapides (OTP & Social)

**Files:**
- Modify: `C:\laragon\www\admin\app\Http\Controllers\RestAPI\v1\auth\CustomerAPIAuthController.php:617-656`
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\customer\checkout\screens\checkout_screen.dart`

**Interfaces:**
- Consumes: `registrationWithOTP`, `registrationWithSocialMedia`
- Produces: Enregistrement optionnel du NNI ou validation au checkout si absent.

- [ ] **Step 1: Ajouter le support du paramètre optionnel `nni` dans `registrationWithOTP`**
  Si fourni dans la requête, vérifier son unicité et l'enregistrer dans `nni_records` et `users.nni_number`.

- [ ] **Step 2: Ajouter une vérification de complétude de profil au Checkout Flutter**
  Si le client connecté n'a pas encore de NNI renseigné, afficher un champ de saisie NNI obligatoire dans la section des informations de livraison du Checkout.

- [ ] **Step 3: Commit**
  `git commit -m "feat(auth): support NNI collection during OTP signup and checkout completion"`

---

### Task 3: Sécurisation du Rejet de Remboursement Côté Vendeur (Note Obligatoire)

**Files:**
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vendor\refund\screens\refund_details_screen.dart`
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vendor\refund\controllers\refund_controller.dart`

**Interfaces:**
- Consumes: `POST /api/v3/seller/refund/refund-status-update` avec `refund_status: "rejected"`, `note: string`

- [ ] **Step 1: Ajouter un dialogue de saisie obligatoire du motif de rejet dans `refund_details_screen.dart`**
  Empêcher l'envoi d'un statut `rejected` si la note explicative est vide ou inférieure à 5 caractères.

- [ ] **Step 2: Transmettre la note dans `refund_controller.dart`**
  Passer la note au repository et vérifier la réponse HTTP 200.

- [ ] **Step 3: Commit**
  `git commit -m "fix(vendor-refund): require rejection note before dispatching refund status update"`

---

### Task 4: Harmonisation Pièces Jointes Tickets de Support & Ordre Chronologique

**Files:**
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vault\support\domain\repositories\support_ticket_repository.dart`
- Modify: `D:\Projets\Yakhoub\opencode\multishop_tchad\flutter_app\lib\features\vault\support\controllers\support_ticket_controller.dart`

**Interfaces:**
- Consumes: `POST /api/v1/customer/support-ticket/create`
- Produces: `MultipartFile` nommé `image[]` et tri chronologique `created_at ASC`.

- [ ] **Step 1: Aligner le champ d'upload des images sur `image[]`**
  Dans `support_ticket_repository.dart`, s'assurer que chaque fichier est ajouté sous la clé `image[]`.

- [ ] **Step 2: Fixer l'ordre des messages dans `support_ticket_controller.dart`**
  Assurer un ordre chronologique ascendant afin que les réponses du support apparaissent naturellement dans la conversation.

- [ ] **Step 3: Commit**
  `git commit -m "fix(support): harmonize attachment field name and message chronological order"`

---

### Task 5: Sécurisation des Devises et Taux Portefeuille (FCFA)

**Files:**
- Modify: `C:\laragon\www\admin\app\Utils\CustomerManager.php:71-78`

**Interfaces:**
- Consumes: `create_wallet_transaction($user_id, $amount, ...)`
- Produces: Débit et crédit exacts en devise système.

- [ ] **Step 1: Vérifier le modèle de devise dans `CustomerManager.php`**
  S'assurer que si `currency_model == 'single_currency'`, aucun calcul multiplicateur ou diviseur ne déforme le montant de 1 000 FCFA.

- [ ] **Step 2: Commit**
  `git commit -m "fix(wallet): ensure 1:1 currency conversion on single-currency wallet operations"`
