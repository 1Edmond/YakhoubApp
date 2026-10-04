import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/helpers/price_converter.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/widgets/base/custom_image_widget.dart';
import 'package:multishop_tchad/core/widgets/base/no_data_screen.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_app_bar_widget.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/models/price_reduction_model.dart';
import 'package:multishop_tchad/features/vendor/order_details/controllers/vendor_reduction_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorNegotiationsScreen extends StatefulWidget {
  const VendorNegotiationsScreen({super.key});

  @override
  State<VendorNegotiationsScreen> createState() => _VendorNegotiationsScreenState();
}

class _VendorNegotiationsScreenState extends State<VendorNegotiationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorReductionController>(context, listen: false).fetchRequests();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBarWidget(
        title: getTranslated('price_negotiations', context) ?? 'Négociations de prix',
      ),
      body: Consumer<VendorReductionController>(
        builder: (context, controller, child) {
          final pending = controller.pendingRequests;
          final history = controller.historyRequests;

          return Column(
            children: [
              // Onglets supérieurs stylisés
              Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hintColor.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                  unselectedLabelStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('pending_negotiations', context) ?? 'En attente'),
                          if (pending.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade700,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${pending.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('history_negotiations', context) ?? 'Historique'),
                          if (history.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${history.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Contenu des onglets
              Expanded(
                child: controller.isLoading && controller.allRequests.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _buildList(context, controller, pending, isPendingTab: true),
                          _buildList(context, controller, history, isPendingTab: false),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    VendorReductionController controller,
    List<PriceReductionModel> items, {
    required bool isPendingTab,
  }) {
    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => controller.fetchRequests(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            alignment: Alignment.center,
            child: const NoDataScreen(
              title: 'no_negotiations_found',
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => controller.fetchRequests(),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildNegotiationCard(context, controller, item, isPendingTab: isPendingTab);
        },
      ),
    );
  }

  Widget _buildNegotiationCard(
    BuildContext context,
    VendorReductionController controller,
    PriceReductionModel item, {
    required bool isPendingTab,
  }) {
    final status = item.status ?? 'pending';
    final double original = item.originalPrice ?? 0;
    final double reduction = item.requestedReduction ?? 0;
    final double proposed = (item.proposedPrice ?? (original - reduction)).clamp(0, double.infinity);
    final int round = item.round ?? 1;

    Color badgeBg;
    Color badgeText;
    IconData badgeIcon;
    String statusTitle;

    switch (status) {
      case 'accepted':
        badgeBg = const Color(0xFFE8F5E9);
        badgeText = const Color(0xFF2E7D32);
        badgeIcon = Icons.check_circle_rounded;
        statusTitle = getTranslated('negotiation_accepted', context) ?? 'Acceptée';
        break;
      case 'refused':
        badgeBg = const Color(0xFFFFEBEE);
        badgeText = const Color(0xFFC62828);
        badgeIcon = Icons.cancel_rounded;
        statusTitle = getTranslated('negotiation_refused', context) ?? 'Refusée';
        break;
      case 'counter_offer':
        badgeBg = const Color(0xFFE3F2FD);
        badgeText = const Color(0xFF1565C0);
        badgeIcon = Icons.sync_alt_rounded;
        statusTitle = getTranslated('counter_offer_received', context) ?? 'Contre-offre envoyée';
        break;
      default:
        badgeBg = const Color(0xFFFFF3E0);
        badgeText = const Color(0xFFE65100);
        badgeIcon = Icons.hourglass_top_rounded;
        statusTitle = getTranslated('waiting_for_vendor', context) ?? 'En attente de réponse';
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: status == 'pending'
              ? Colors.orange.withValues(alpha: 0.35)
              : Theme.of(context).dividerColor.withValues(alpha: 0.5),
          width: status == 'pending' ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. En-tête de la carte : Profil Client + Badge de Statut
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Row(
              children: [
                // Avatar client
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Nom du client & Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.customerName?.isNotEmpty == true
                            ? item.customerName!
                            : 'Client MultiShop',
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault + 1,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: Theme.of(context).hintColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.createdAt ?? 'Récemment',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context).hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bouton Appel direct si téléphone présent
                if (item.customerPhone != null && item.customerPhone!.trim().isNotEmpty) ...[
                  InkWell(
                    onTap: () async {
                      final uri = Uri.parse('tel:${item.customerPhone}');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.phone_in_talk_rounded,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ),
                ],

                // Badge Statut
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(badgeIcon, size: 14, color: badgeText),
                      const SizedBox(width: 5),
                      Text(
                        statusTitle,
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: badgeText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // 2. Section Produit
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomImageWidget(
                      image: item.productThumbnail ?? '',
                      height: 58,
                      width: 58,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName ??
                            (item.orderId != null
                                ? 'Commande #${item.orderId}'
                                : 'Article du panier'),
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.orderId != null
                                  ? 'Commande #${item.orderId}'
                                  : 'Panier Client',
                              style: robotoMedium.copyWith(
                                fontSize: 11,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: round >= 2
                                  ? Colors.orange.withValues(alpha: 0.12)
                                  : Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              round >= 2 ? 'Tour 2/2 (Dernier)' : 'Tour 1/2',
                              style: robotoBold.copyWith(
                                fontSize: 11,
                                color: round >= 2 ? Colors.orange.shade800 : Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Bloc Financier : Clarté absolue des chiffres
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              children: [
                if (original > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prix catalogue :',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        PriceConverter.convertPrice(context, original),
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Réduction demandée :',
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Colors.red.shade700,
                      ),
                    ),
                    Text(
                      '- ${PriceConverter.convertPrice(context, reduction)}',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prix final proposé par le client :',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      PriceConverter.convertPrice(context, proposed),
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Si contre-offre émise
          if (status == 'counter_offer' && item.counterOfferAmount != null) ...[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.reply_rounded, color: Color(0xFF1565C0), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Votre contre-offre : - ${PriceConverter.convertPrice(context, item.counterOfferAmount!)} (en attente du client)',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: const Color(0xFF1565C0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // 4. Section Boutons d'Action Vendeur (Redesign complet ergonomique)
          if (status == 'pending') ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Bouton Principal : Accepter
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                      label: Text(
                        getTranslated('accept_reduction', context) ?? 'Accepter la réduction',
                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      ),
                      onPressed: controller.isLoading
                          ? null
                          : () => controller.acceptReduction(item.id!, context, orderId: item.orderId),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Ligne des actions secondaires : Contre-offre & Refuser
                  Row(
                    children: [
                      // Contre-offre (si round < 2)
                      if (round < 2) ...[
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976D2),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.swap_horiz_rounded, size: 20),
                              label: Text(
                                getTranslated('make_counter_offer', context) ?? 'Contre-offre',
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),
                              ),
                              onPressed: controller.isLoading
                                  ? null
                                  : () => _showCounterOfferBottomSheet(
                                        context,
                                        controller,
                                        item,
                                      ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],

                      // Refuser
                      Expanded(
                        flex: round < 2 ? 2 : 1,
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFC62828),
                              backgroundColor: const Color(0xFFFFEBEE),
                              side: const BorderSide(color: Color(0xFFEF9A9A), width: 1.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.close_rounded, size: 18),
                            label: Text(
                              getTranslated('refuse_reduction', context) ?? 'Refuser',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),
                            ),
                            onPressed: controller.isLoading
                                ? null
                                : () => controller.refuseReduction(item.id!, context, orderId: item.orderId),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  // Dialogue / Modal moderne de contre-proposition
  void _showCounterOfferBottomSheet(
    BuildContext context,
    VendorReductionController controller,
    PriceReductionModel item,
  ) {
    int? selectedTier;
    final double originalPrice = item.originalPrice ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            final double counterReduction = (selectedTier ?? 0).toDouble();
            final double proposedCustomerPrice =
                (originalPrice - counterReduction).clamp(0, double.infinity);

            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(modalContext).viewInsets.bottom + 24,
              ),
              decoration: BoxDecoration(
                color: Theme.of(modalContext).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poignée de glissement
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(modalContext).hintColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Titre
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(modalContext).primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.swap_horiz_rounded,
                          color: Theme.of(modalContext).primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated('make_counter_offer', modalContext) ?? 'Faire une contre-proposition',
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                            ),
                            Text(
                              'Paliers réglementaires CDC 3.4.7',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(modalContext).hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    getTranslated('select_counter_tier', modalContext) ??
                        'Sélectionnez le montant de réduction à proposer au client :',
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  const SizedBox(height: 12),

                  // Grille des 11 paliers CDC 3.4.7
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.tiers.map((tier) {
                      final isSelected = selectedTier == tier;
                      return ChoiceChip(
                        label: Text(
                          '- $tier FCFA',
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: isSelected ? Colors.white : Theme.of(modalContext).textTheme.bodyLarge?.color,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Theme.of(modalContext).primaryColor,
                        backgroundColor: Theme.of(modalContext).highlightColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(modalContext).primaryColor
                                : Theme.of(modalContext).dividerColor.withValues(alpha: 0.6),
                          ),
                        ),
                        onSelected: (selected) {
                          setModalState(() {
                            selectedTier = selected ? tier : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Résumé en temps réel si palier sélectionné
                  if (selectedTier != null && originalPrice > 0) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nouveau prix que paiera le client :',
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          Text(
                            PriceConverter.convertPrice(modalContext, proposedCustomerPrice),
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault + 1,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Boutons d'action du modal
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(
                            getTranslated('cancel', modalContext) ?? 'Annuler',
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(modalContext).primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: selectedTier == null
                              ? null
                              : () async {
                                  Navigator.pop(ctx);
                                  await controller.sendCounterOffer(
                                    item.id!,
                                    selectedTier!.toDouble(),
                                    context,
                                    orderId: item.orderId,
                                  );
                                },
                          child: Text(
                            getTranslated('submit', modalContext) ?? 'Envoyer la proposition',
                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
