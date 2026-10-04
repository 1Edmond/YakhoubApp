import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/widgets/base/vendor_custom_app_bar_widget.dart';
import 'package:multishop_tchad/core/widgets/base/custom_image_widget.dart';
import 'package:multishop_tchad/core/widgets/base/no_data_screen.dart';
import 'package:multishop_tchad/features/customer/order_details/domain/models/price_reduction_model.dart';
import 'package:multishop_tchad/features/vendor/order_details/controllers/vendor_reduction_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorNegotiationsScreen extends StatefulWidget {
  const VendorNegotiationsScreen({super.key});

  @override
  State<VendorNegotiationsScreen> createState() => _VendorNegotiationsScreenState();
}

class _VendorNegotiationsScreenState extends State<VendorNegotiationsScreen> with SingleTickerProviderStateMixin {
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
      appBar: CustomAppBarWidget(
        title: getTranslated('price_negotiations', context) ?? 'Négociations de prix',
      ),
      body: Consumer<VendorReductionController>(
        builder: (context, controller, child) {
          final pending = controller.pendingRequests;
          final history = controller.historyRequests;

          return Column(
            children: [
              Container(
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).hintColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('pending_negotiations', context) ?? 'En attente'),
                          if (pending.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${pending.length}',
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Tab(
                      child: Text(
                        '${getTranslated('history_negotiations', context) ?? 'Historique'} (${history.length})',
                      ),
                    ),
                  ],
                ),
              ),
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
            height: MediaQuery.of(context).size.height * 0.6,
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
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: Dimensions.paddingSizeSmall),
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
    final requested = item.requestedReduction?.toStringAsFixed(0) ?? '0';

    Color statusColor;
    String statusText;
    switch (status) {
      case 'accepted':
        statusColor = Colors.green;
        statusText = getTranslated('negotiation_accepted', context) ?? 'Acceptée';
        break;
      case 'refused':
        statusColor = Colors.red;
        statusText = getTranslated('negotiation_refused', context) ?? 'Refusée';
        break;
      case 'counter_offer':
        statusColor = Colors.blue;
        statusText = getTranslated('counter_offer_received', context) ?? 'Contre-offre envoyée';
        break;
      default:
        statusColor = Colors.orange;
        statusText = getTranslated('waiting_for_vendor', context) ?? 'En attente';
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête : Client info + Statut
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                child: Icon(Icons.person, color: Theme.of(context).primaryColor, size: 20),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.customerName ?? 'Client MultiShop',
                      style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.createdAt != null)
                      Text(
                        item.createdAt!,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (item.customerPhone != null && item.customerPhone!.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  tooltip: 'Appeler le client',
                  onPressed: () async {
                    final uri = Uri.parse('tel:${item.customerPhone}');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusText,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          const Divider(height: 20),

          // Produit ou commande
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CustomImageWidget(
                  image: item.productThumbnail ?? '',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName ?? (item.orderId != null ? 'Commande #${item.orderId}' : 'Produit au panier'),
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Réduction demandée : ',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                        Text(
                          '- $requested FCFA',
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    if (item.round != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Tour ${item.round}/2',
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Contre-offre existante
          if (status == 'counter_offer' && item.counterOfferAmount != null) ...[
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.reply, color: Colors.blue, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Votre contre-offre : - ${item.counterOfferAmount?.toStringAsFixed(0)} FCFA (en attente)',
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Actions vendeur pour les requêtes en attente
          if (status == 'pending') ...[
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.acceptReduction(item.id!, context, orderId: item.orderId),
                    child: Text(getTranslated('accept_reduction', context) ?? 'Accepter'),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.refuseReduction(item.id!, context, orderId: item.orderId),
                    child: Text(getTranslated('refuse_reduction', context) ?? 'Refuser'),
                  ),
                ),
                if ((item.round ?? 1) < 2) ...[
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: controller.isLoading
                          ? null
                          : () => _showCounterOfferDialog(context, controller, item.id!, item.orderId),
                      child: Text(getTranslated('make_counter_offer', context) ?? 'Contre-offre'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showCounterOfferDialog(
    BuildContext context,
    VendorReductionController controller,
    int requestId,
    int? orderId,
  ) {
    int? selectedTier;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text(getTranslated('make_counter_offer', context) ?? 'Faire une contre-proposition'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslated('select_counter_tier', context) ?? 'Sélectionnez un palier alternatif (FCFA) :'),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: controller.tiers.map((tier) {
                      final isSelected = selectedTier == tier;
                      return ChoiceChip(
                        label: Text('- $tier FCFA'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setDialogState(() {
                            selectedTier = selected ? tier : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(getTranslated('cancel', context) ?? 'Annuler'),
                ),
                ElevatedButton(
                  onPressed: selectedTier == null
                      ? null
                      : () async {
                          Navigator.pop(ctx);
                          await controller.sendCounterOffer(
                            requestId,
                            selectedTier!.toDouble(),
                            context,
                            orderId: orderId,
                          );
                        },
                  child: Text(getTranslated('submit', context) ?? 'Envoyer'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
