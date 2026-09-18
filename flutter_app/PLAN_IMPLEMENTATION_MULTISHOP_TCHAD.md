# Plan d'implémentation — MultiShop Tchad

## 1. Objectif du projet

Construire une application mobile e-commerce multi-boutiques pour le Tchad (cahier des charges complet fourni), avec trois profils : Administrateur (panel web), Propriétaire de magasin (Vendeur), Client (Acheteur). Une seule application mobile héberge les rôles Client et Vendeur, avec un routage conditionné par le rôle de l'utilisateur connecté.

Le projet part de trois blocs de code source existants et fonctionnels (base **6valley v16.5**) :
- `User app/` — application Flutter côté client
- `Vendor app/` — application Flutter côté vendeur
- `Admin V16.5/` — backend Laravel 12 (API REST v1 client + v3 vendeur) + panel admin web

**Principe directeur du projet : on ne réécrit pas ce qui existe déjà.** `User app/` et `Vendor app/` contiennent déjà des dizaines d'écrans fonctionnels et un ensemble de widgets réutilisables (`common/basewidget/`). Le travail consiste à **adapter et assembler** ce code existant pour répondre au cahier des charges, pas à repartir d'une page blanche. Chaque écran livré doit pouvoir être rattaché à un fichier source précis dont il est issu.

---

## 2. Décisions de conception

| # | Sujet | Décision |
|---|---|---|
| 1 | Backend | Adapter le Laravel 12 existant (`Admin V16.5/`), pas de réécriture |
| 2 | Apps mobiles | Fusionner `User app` + `Vendor app` en **une seule application** Flutter, routage par rôle |
| 3 | Features hors cahier des charges | Conservées dans le code, déplacées dans un module `vault/`, invisibles en interface, activables uniquement via un mécanisme développeur caché — rien n'est supprimé |
| 4 | NNI (Numéro National d'Identification) | Table séparée `nni_records` (FK vers `users`) — pas de colonnes NNI dans la table `users` |
| 5 | Admin | Reste uniquement sur le panel web Laravel existant, pas d'app mobile admin |
| 6 | Photo de porte | Double stockage : Firebase Storage + serveur Laravel |
| 7 | Paiement Airtel Money / Moov Money | Pas d'API disponible actuellement → architecture en interface abstraite (`PaymentGateway`) avec implémentations stub qui échouent explicitement (pas de faux succès simulé), prêtes à recevoir les vraies clés API sans retoucher le reste du code |
| 8 | Package Flutter | `com.multishop.tchad` |
| 9 | Langues | Application bilingue **Français / Arabe** (les deux langues officielles du Tchad), avec support RTL complet pour l'arabe — pas seulement le français demandé littéralement par le cahier des charges |

---

## 3. Architecture cible

```
lib/
├── core/
│   ├── constants/                 # base URL, endpoints, paliers de réduction, frais annulation
│   ├── theme/                     # thème clair/sombre unifié
│   ├── localization/              # français + arabe (RTL) — infrastructure existante réutilisée
│   ├── router/                    # GoRouter unique, guards par rôle
│   ├── di/                        # UN SEUL conteneur d'injection de dépendances (GetIt)
│   ├── feature_vault/             # système de features cachées
│   ├── helpers/                   # validateurs (dont NNI), formatters, network info
│   └── widgets/                   # widgets communs fusionnés (basewidget client + vendeur, dédupliqués)
├── features/
│   ├── auth/                      # login unique, 2 flux d'inscription (client / vendeur)
│   ├── customer/                  # écrans client adaptés du cahier des charges
│   ├── vendor/                    # écrans vendeur adaptés du cahier des charges
│   ├── shared/                    # chat, notifications, paiement
│   └── vault/                     # modules hors CDC, intacts, masqués par défaut
└── main.dart                      # point d'entrée unique
```

**Stack :** Flutter (SDK `^3.6.0`), Provider + GetIt, GoRouter, Dio, Firebase Auth/Storage/FCM, Google Maps API.

---

## 4. Table de correspondance — exigences du cahier des charges → code source à réutiliser

Colonne "Action" :
- **REUSE** — reprendre le fichier tel quel (renommage/déplacement possible), pas de réécriture d'UI
- **ADAPT** — partir de l'écran existant, modifier les champs/la logique, garder la structure et les widgets
- **NEW (compose)** — aucun équivalent existant ; l'écran est composé à partir des widgets déjà présents dans `common/basewidget/`, jamais construit avec des éléments d'UI ad hoc

### 4.1 Côté Client (source : `User app/lib/features/`)

| Exigence CDC | Écran(s) source | Action | Notes |
|---|---|---|---|
| 3.1.1 Inscription client | `auth/screens/auth_screen.dart`, `otp_registration_screen.dart` | ADAPT | Ajouter les champs NNI (numéro, nom, prénom, date de naissance) + téléphone Airtel/Moov |
| 3.1.3 Connexion (email + Google) | `auth/screens/login_screen.dart`, `forget_password_screen.dart`, `reset_password_screen.dart`, `otp_login_screen.dart`, `otp_verification_screen.dart` | REUSE | Déjà conforme au CDC |
| 3.4.1 Accueil + produits vedettes | `home/screens/home_screens.dart` (garder un seul thème parmi `aster_theme_home_screen.dart` / `fashion_theme_home_screen.dart`) | ADAPT | Retirer les sections deals/enchères/blog (→ vault), garder produits vedettes + catégories + recherche |
| 3.4.1 Recherche + filtres | `search_product/screens/search_product_screen.dart` | ADAPT | Filtres CDC : catégorie, magasin, prix, marque, couleur, taille |
| 3.4.2 Fiche produit | `product_details/screens/product_details_screen.dart`, `product_image_screen.dart`, `specification_screen.dart` | REUSE | Galerie, couleurs, tailles, marque/modèle déjà conformes |
| 3.4.3 Panier | `cart/screens/cart_screen.dart` | ADAPT | Ajouter le regroupement par magasin + bouton "Demander une réduction" |
| 3.4.4 Commande — récapitulatif, adresse, paiement | `checkout/screens/checkout_screen.dart` | ADAPT | Adresse Tchad (quartier/rue/description) + écran photo de porte + paiement Airtel/Moov uniquement |
| 3.4.4 Adresse de livraison | `address/screens/add_new_address_screen.dart`, `address_list_screen.dart` | ADAPT | Champs adaptés au format Tchad |
| 3.4.5 Suivi de commande | `order/screens/order_screen.dart`, `order_details/screens/order_details_screen.dart`, `guest_track_order_screen.dart` | ADAPT | 6 statuts CDC avec couleurs (🟡🟠🔵🟣🟢🔴) |
| 3.4.6 Annulation de commande | — (le module `refund/` existant gère un flux différent, non réutilisable ici) | NEW (compose) | Composer avec `confirmation_dialog_widget.dart`, `custom_button_widget.dart`, `success_dialog_widget.dart` |
| 3.4.7 Demande de réduction par palier | — | NEW (compose) | Composer avec `custom_button_widget.dart`, `amount_widget.dart`, `status_badge_widget.dart`, `animated_custom_dialog_widget.dart` |
| 3.5 Paiement Airtel/Moov | `checkout/screens/digital_payment_order_place_screen.dart` | ADAPT | Remplacer la liste des gateways par Airtel/Moov (stub) |
| 3.6.3 Photo de porte géolocalisée | Logique de géolocalisation de `location/screens/select_location_screen.dart` | NEW (compose) | Réutiliser la logique de géoloc existante, ajouter capture caméra + `custom_image_widget.dart` |
| 3.7 Notifications | `notification/screens/notification_screen.dart` | REUSE | Adapter la liste des types de notification |
| Profil client (+ NNI) | `profile/screens/profile_screen.dart` | ADAPT | Ajouter l'affichage NNI |
| Vue boutique vendeur | `shop/screens/shop_screen.dart`, `overview_screen.dart`, `all_shop_screen.dart` | REUSE | Déjà conforme |
| Splash / onboarding / maintenance | `splash/`, `onboarding/`, `maintenance/` | REUSE | Aucun changement |

### 4.2 Côté Vendeur (source : `Vendor app/lib/features/`)

| Exigence CDC | Écran(s) source | Action | Notes |
|---|---|---|---|
| 3.1.2 Inscription vendeur (+ magasin) | `auth/screens/registration_screen.dart` | ADAPT | Ajouter NNI, vérifier logo/catégorie/description magasin |
| 3.1.3 Connexion | `auth/screens/login_screen.dart`, `forget_password_screen.dart`, `otp_verification_screen.dart` | REUSE | Déjà conforme |
| Écran "en attente de validation" | — | NEW (compose) | Aucun équivalent — écran simple à un seul état, composé avec les widgets existants |
| 3.3.1 Gestion du magasin | `shop/screens/shop_screen.dart`, `shop_update_screen.dart`, `vacation_mode_setup_screen.dart` (base pour les horaires d'ouverture) | ADAPT | `vacation_mode_setup_screen.dart` est la base la plus proche pour les horaires |
| 3.3.2 Gestion produits | `addProduct/screens/add_product_screen.dart`, `add_product_next_screen.dart`, `add_product_tab_view_screen.dart` | ADAPT | Vérifier tous les champs CDC (couleur, taille XS-XXL, marque, modèle, réduction) ; `add_product_seo_screen.dart` hors CDC, à masquer |
| Liste produits | `product/screens/product_list_screen.dart`, `product_list_view_screen.dart`, `stock_out_product_screen.dart` | REUSE | Rupture de stock déjà couverte |
| 3.3.3 Gestion commandes | `order/screens/order_screen.dart`, `order_details/screens/order_details_screen.dart` | ADAPT | Filtres par statut CDC + changement de statut + notification client |
| 3.3.4 Statistiques | `dashboard/screens/dashboard_screen.dart` | REUSE | Vérifier ventes jour/semaine/mois, CA, top produits |
| Réponse aux demandes de réduction | — | NEW (compose) | Composer avec les cartes/boutons d'action déjà utilisés dans dashboard/order |
| Profil vendeur (+ NNI) | `profile/screens/profile_screen.dart`, `profile_view_screen.dart` | ADAPT | Ajouter affichage NNI |
| Infos bancaires / paiement | `shop/screens/add_payment_info_screen.dart`, `payment_info_screen.dart` | REUSE | Utile pour recevoir les paiements Airtel/Moov, garder actif |
| Splash / maintenance / langue | `splash/`, `maintenance/`, `language/` | REUSE | Aucun changement |

**Règle stricte : avant de créer un nouveau widget, vérifier s'il existe déjà un équivalent dans `common/basewidget/`. Si oui, l'utiliser ou l'étendre — jamais le dupliquer.**

---

## 5. Modules déplacés dans le FeatureVault (masqués par défaut, code conservé intact)

**Côté client :** `ai_shopping`, tous les modules `auction*` (auction, auction_ai, auction_category, auction_checkout, auction_dashboard_summary, auction_details, auction_home, auction_list, auction_search, auction_transaction, user_created_auction_list, create_auction), `blog`, `clearance_sale`, `compare`, `contact_us`, `coupon`, `deal`, `loyaltyPoint`, `offline_payment`, `refer_and_earn`, `support`, `vat_tax`, `wallet`, `transaction`, `refund` (module générique, distinct de l'annulation CDC), `reorder`, `restock`, `review`, `banner`.

**Côté vendeur :** `ai`, `auction`, `barcode`, `clearance_sale`, `coupon`, `delivery_man`, `emergency_contract`, `order_edit`, `pos`, `third_party_deliveryman`, `vat_management`.

Mécanisme d'activation : séquence secrète dans Paramètres > À propos (taper 7 fois sur le numéro de version) → saisie d'un PIN (hash stocké, jamais en clair) → panneau développeur avec toggles par feature. Chaque route vault est protégée par un guard qui vérifie l'activation.

---

## 6. Backend Laravel — modifications

### Nouvelles tables

**`nni_records`**
```sql
CREATE TABLE nni_records (
    id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id       BIGINT UNSIGNED NOT NULL,
    nni_number    VARCHAR(30) NOT NULL UNIQUE,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    place_of_birth VARCHAR(150) NULL,
    gender        ENUM('male','female') NULL,
    document_type ENUM('nni','passport') DEFAULT 'nni',
    is_verified   BOOLEAN DEFAULT FALSE,
    verified_at   TIMESTAMP NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE INDEX idx_nni_number (nni_number)
);
```

**`price_reduction_requests`**
```sql
CREATE TABLE price_reduction_requests (
    id                    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id              BIGINT UNSIGNED NOT NULL,
    customer_id           BIGINT UNSIGNED NOT NULL,
    vendor_id             BIGINT UNSIGNED NOT NULL,
    original_price        DECIMAL(12,2) NOT NULL,
    requested_reduction   DECIMAL(12,2) NOT NULL,
    proposed_price        DECIMAL(12,2) NULL,
    status                ENUM('pending','accepted','refused','counter_offer',
                               'counter_accepted','counter_refused') DEFAULT 'pending',
    counter_offer_amount  DECIMAL(12,2) NULL,
    round_number          TINYINT UNSIGNED DEFAULT 1,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (vendor_id) REFERENCES users(id)
);
```

**`reduction_tiers`**
```sql
CREATE TABLE reduction_tiers (
    id        BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tier      TINYINT UNSIGNED NOT NULL,
    amount    DECIMAL(12,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO reduction_tiers (tier, amount) VALUES
(1, 250), (2, 500), (3, 1000), (4, 1500), (5, 2000),
(6, 2500), (7, 3000), (8, 3500), (9, 4000), (10, 5000), (11, 10000);
```

**Colonnes ajoutées à `orders`**
```sql
ALTER TABLE orders
ADD COLUMN has_reduction BOOLEAN DEFAULT FALSE,
ADD COLUMN reduction_amount DECIMAL(12,2) DEFAULT 0,
ADD COLUMN final_price DECIMAL(12,2) NULL,
ADD COLUMN cancellation_fee DECIMAL(12,2) DEFAULT 1000.00,
ADD COLUMN door_photo_url VARCHAR(500) NULL,
ADD COLUMN door_photo_firebase_url VARCHAR(500) NULL,
ADD COLUMN door_latitude DECIMAL(10,8) NULL,
ADD COLUMN door_longitude DECIMAL(11,8) NULL;
```

### Nouveaux endpoints

| Méthode | Endpoint | Description |
|---|---|---|
| POST | `/api/v1/auth/register` | Inscription client (modifié : + NNI) |
| POST | `/api/v3/seller/registration` | Inscription vendeur (modifié : + NNI) |
| GET | `/api/v1/reduction-tiers` | Liste des paliers de réduction |
| POST | `/api/v1/customer/order/{id}/request-reduction` | Demander une réduction |
| GET | `/api/v1/customer/reduction-requests` | Mes demandes de réduction |
| GET | `/api/v3/seller/reduction-requests` | Demandes reçues (vendeur) |
| PUT | `/api/v3/seller/reduction-requests/{id}/respond` | Accepter/Refuser/Contre-proposer |
| POST | `/api/v1/customer/order/{id}/cancel` | Annuler commande (1000 FCFA fixe) |
| POST | `/api/v1/payments/airtel-money` | Paiement Airtel Money (stub) |
| POST | `/api/v1/payments/moov-money` | Paiement Moov Money (stub) |
| GET | `/api/v1/payments/{id}/status` | Statut paiement |

---

## 7. Module Paiement Mobile Money (architecture prête, implémentation en attente)

```dart
abstract class PaymentGateway {
  Future<PaymentResult> initiatePayment(PaymentRequest request);
  Future<PaymentStatus> checkStatus(String transactionId);
  Future<RefundResult> refund(String transactionId, double amount);
}

class AirtelMoneyGateway implements PaymentGateway {
  @override
  Future<PaymentResult> initiatePayment(PaymentRequest request) async {
    throw UnimplementedError('Airtel Money API non encore configurée');
  }
}

class MoovMoneyGateway implements PaymentGateway {
  @override
  Future<PaymentResult> initiatePayment(PaymentRequest request) async {
    throw UnimplementedError('Moov Money API non encore configurée');
  }
}
```

Aucune clé API en dur dans le code — variables d'environnement (`AIRTEL_MONEY_API_KEY`, `MOOV_MONEY_API_KEY`) documentées mais vides. Le jour où les clés sont disponibles, seule l'implémentation de ces deux classes change, le reste du flux (écrans, statuts, base de données, webhooks) est déjà prêt.

---

## 8. Localisation complète (Français / Arabe)

Le Tchad a le français **et** l'arabe comme langues officielles. Le cahier des charges ne mentionne que le français, mais pour une application commerciale grand public destinée au marché tchadien, une localisation partielle serait un manque majeur. Cette section couvre une localisation **complète**, pas un simple fichier de traduction ajouté après coup.

### 8.1 Principe de réutilisation

`User app` et `Vendor app` ont déjà une infrastructure de localisation fonctionnelle (`core/localization/` avec `LocalizationController`, `AppLocalization`, `language_constrants.dart`, et des fichiers `assets/language/*.json`). **On ne reconstruit pas ce système** — on l'étend :
1. Auditer les langues déjà présentes dans `assets/language/` des deux apps
2. Ajouter un fichier `ar.json` (côté client) et son équivalent côté vendeur, avec la traduction de **toutes** les clés existantes — pas un sous-ensemble
3. Toute nouvelle clé créée pour les écrans propres à ce projet (réduction, annulation, NNI, photo de porte, panneau FeatureVault) est traduite en français **et** en arabe dès sa création, jamais après coup

### 8.2 Ce que "vraiment complet" couvre

| Élément | Exigence |
|---|---|
| Interface mobile (client + vendeur) | 100% des chaînes de caractères passent par le système de traduction — aucun texte en dur dans le code |
| RTL (droite-à-gauche) | Tous les écrans, y compris ceux créés pour ce projet, doivent s'afficher correctement en RTL : icônes directionnelles inversées (flèches retour, chevrons), paddings/alignements non figés à gauche, mise en page testée dans les deux sens |
| Police arabe | Ajouter une police supportant correctement les diacritiques arabes (ex. Cairo, Noto Naskh Arabic, ou Almarai) dans `pubspec.yaml` — la police latine par défaut rend mal l'arabe |
| Formats régionaux | Dates, nombres, devise (FCFA) formatés selon la langue active (package `intl`) |
| Notifications FCM | Titre/corps envoyés dans la langue préférée de l'utilisateur — nécessite de stocker cette préférence en base (colonne `preferred_language` sur `users`) |
| Emails transactionnels Laravel | Templates dupliqués `resources/lang/fr/` et `resources/lang/ar/` (validation vendeur, réinitialisation mot de passe, etc.) |
| Sélecteur de langue | Écran Paramètres, persistant (SharedPreferences), changement appliqué sans redémarrage de l'app |
| Panel admin web | Hors périmètre mobile — vérifier si déjà bilingue dans 6valley ; sinon rester en français, acteur interne non prioritaire |

### 8.3 Point à trancher — contenu vendeur bilingue ou non

Il y a une différence entre "l'interface est bilingue" (labels, boutons, messages système — toujours vrai) et "le contenu que les vendeurs saisissent est bilingue" (nom/description de produit, nom/description de magasin — pas toujours souhaitable, car ça impose une double saisie à chaque vendeur).

**Par défaut dans ce plan :** seule l'interface est bilingue FR/AR ; le contenu produit/magasin reste dans la langue choisie par le vendeur au moment de la saisie (une seule langue, pas de champ dupliqué). Si tu veux au contraire que les fiches produits soient aussi disponibles dans les deux langues, il faut ajouter des tables `product_translations` / `store_translations` côté Laravel — dis-le-moi si c'est ce que tu veux, sinon on part sur l'option par défaut.

### 8.4 Definition of Done — localisation

- Aucun `Text('...')` en dur dans le code livré pour ce projet — tout passe par le système de traduction existant
- `assets/language/fr.json` et `assets/language/ar.json` (et leurs équivalents côté vendeur) contiennent exactement le même nombre de clés — vérifiable par un diff simple des clés JSON
- Test manuel : basculer l'application entière en arabe → tous les écrans (y compris réduction, annulation, NNI, photo de porte, FeatureVault) s'affichent correctement en RTL, aucun texte tronqué, aucune icône mal orientée
- Une notification déclenchée pour un utilisateur ayant choisi l'arabe arrive bien en arabe

---

## 9. Phases d'exécution

Chaque phase se termine par une vérification **vérifiable mécaniquement**, avec preuve (sortie de commande) fournie par Claude Code — pas une simple déclaration que "c'est fait".

### Phase 0 — Initialisation du dépôt
- Partir de `User app/`, `Vendor app/`, `Admin V16.5/` comme sources
- Écrire un `.gitignore` couvrant `build/`, `.dart_tool/`, `ios/Pods/` **avant** le premier commit
- **Vérification :** `git status` après `flutter pub get` ne montre aucun fichier de `build/` ou `Pods/` suivi ; aucun dossier `build` sous `lib/`

### Phase 1 — Structure du projet unifié
- Créer l'arborescence `core/` + squelette `features/` (section 3)
- Fusionner `pubspec.yaml` (superset des deux apps)
- **Vérification :** `flutter pub get` réussit ; un seul fichier `main.dart` dans tout `lib/`

### Phase 2 — FeatureVault
- Système d'activation caché (section 5)
- **Vérification :** toggle testable manuellement, aucune régression sur les routes publiques

### Phase 3 — Auth unifiée + NNI
- Suivre la table §4.1/§4.2 (réutilisation massive)
- **Vérification :** flux complet testable — inscription client avec NNI → vérification → login → dashboard ; inscription vendeur → écran d'attente → validation admin → dashboard vendeur

### Phase 4 — Router unifié + Role Guards
- **Vérification :** une seule occurrence de `void main(` dans tout `lib/` ; navigation testée pour les 2 rôles, aucun accès croisé possible

### Phase 5 — Backend Laravel
- Migrations et endpoints de la section 6
- **Vérification :** `php artisan migrate` sans erreur ; endpoints testés (Postman/curl) avec réponses conformes

### Phase 6 — Features Client
- Suivre strictement la table §4.1
- **Vérification :** pour chaque écran livré, Claude Code indique explicitement le fichier source dont il est parti (REUSE/ADAPT) ou justifie un NEW (compose) avec la liste des widgets réutilisés

### Phase 7 — Features Vendeur
- Suivre strictement la table §4.2, même exigence de traçabilité

### Phase 8 — Paiement Mobile Money
- Architecture de la section 7
- **Vérification :** une tentative de paiement sans clé API configurée renvoie une erreur claire et loggée, jamais un succès silencieux

### Phase 9 — Notifications, localisation FR/AR, finitions
- Adapter le système FCM existant aux types CDC (tableau 3.7), en respectant la langue préférée du destinataire
- Appliquer la section 8 dans son intégralité : audit des clés existantes, ajout de `ar.json`, police arabe, RTL, formats régionaux, emails Laravel bilingues
- Mode sombre sur tous les écrans, dans les deux langues
- **Vérification :** Definition of Done de la section 8.4 remplie ; chaque type de notification du cahier des charges déclenché au moins une fois en test manuel, dans les deux langues

---

## 10. Vérification finale globale

- `flutter analyze` : 0 erreur
- `flutter build apk --debug` réussit
- Aucun dossier `build/`, `Pods/`, `.dart_tool/` suivi par git
- Un seul `main.dart`, un seul conteneur DI, un seul système de thème/localisation
- `fr.json` et `ar.json` (client + vendeur) à parité complète de clés, RTL vérifié sur tous les écrans
- Parcours manuel de bout en bout rejoué et confirmé fonctionnel, **en français et en arabe** : inscription (client + vendeur) → validation admin → connexion → ajout produit → commande (panier multi-magasins, adresse Tchad, photo de porte) → demande de réduction → réponse vendeur → paiement (échoue proprement, clé absente) → annulation avant expédition (1000 FCFA) → notifications déclenchées à chaque étape

---

## 11. Points à valider avec toi avant le lancement

- Les modules "gris" de la section 5 (`wallet`, `review`, `transaction`...) — à garder actifs ou dans le vault par défaut ?
- Contenu exact souhaité pour l'écran "vendeur en attente de validation" (aucun équivalent dans le code existant, à concevoir simplement).
- Section 8.3 : le contenu saisi par les vendeurs (produits, magasins) doit-il aussi être bilingue, ou seule l'interface doit l'être ? Par défaut ce plan part sur "interface bilingue, contenu vendeur en langue unique".
