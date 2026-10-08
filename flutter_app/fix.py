import re

# Fix controller
with open('lib/features/vendor/order_details/controllers/vendor_reduction_controller.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('bool _isLoading = false;\n  bool get isLoading => _isLoading;', '''bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _processingId;
  String? _processingAction;

  bool isProcessing(int id, String action) {
    return _processingId == id && _processingAction == action;
  }
  
  bool isAnyProcessing(int id) {
    return _processingId == id;
  }''')

content = re.sub(r'Future<bool> acceptReduction\(int requestId, BuildContext context, \{int\? orderId\}\) async \{.*?(ApiResponseModel response = await vendorReductionRepository\.acceptReduction\(requestId\);).*?if \(response\.response', '''Future<bool> acceptReduction(int requestId, BuildContext context, {int? orderId}) async {
    _processingId = requestId;
    _processingAction = 'accept';
    notifyListeners();
    
    ApiResponseModel response = await vendorReductionRepository.acceptReduction(requestId);
    
    _processingId = null;
    _processingAction = null;
    if (response.response''', content, flags=re.DOTALL)

content = re.sub(r'Future<bool> refuseReduction\(int requestId, BuildContext context, \{int\? orderId\}\) async \{.*?(ApiResponseModel response = await vendorReductionRepository\.refuseReduction\(requestId\);).*?if \(response\.response', '''Future<bool> refuseReduction(int requestId, BuildContext context, {int? orderId}) async {
    _processingId = requestId;
    _processingAction = 'refuse';
    notifyListeners();
    
    ApiResponseModel response = await vendorReductionRepository.refuseReduction(requestId);
    
    _processingId = null;
    _processingAction = null;
    if (response.response''', content, flags=re.DOTALL)

content = re.sub(r'Future<bool> sendCounterOffer\(int requestId, double counterAmount, BuildContext context, \{int\? orderId\}\) async \{.*?(ApiResponseModel response = await vendorReductionRepository\.counterOffer\(requestId, counterAmount\);).*?if \(response\.response', '''Future<bool> sendCounterOffer(int requestId, double counterAmount, BuildContext context, {int? orderId}) async {
    _processingId = requestId;
    _processingAction = 'counter';
    notifyListeners();
    
    ApiResponseModel response = await vendorReductionRepository.counterOffer(requestId, counterAmount);
    
    _processingId = null;
    _processingAction = null;
    if (response.response''', content, flags=re.DOTALL)

with open('lib/features/vendor/order_details/controllers/vendor_reduction_controller.dart', 'w', encoding='utf-8') as f:
    f.write(content)


# Fix screen buttons
with open('lib/features/vendor/negotiation/screens/vendor_negotiations_screen.dart', 'r', encoding='utf-8') as f:
    ui = f.read()

ui = ui.replace('controller.isLoading\\n                          ? null\\n                          : () => controller.acceptReduction(item.id!, context, orderId: item.orderId),', 'controller.isAnyProcessing(item.id!) ? null : () => controller.acceptReduction(item.id!, context, orderId: item.orderId),')

ui = ui.replace('icon: const Icon(Icons.check_circle_outline_rounded, size: 20),\\n                      label: Text(\\n                        getTranslated(\\'accept_reduction\\', context) ?? \\'Accepter la rÃ©duction\\',\\n                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),\\n                      ),', 'icon: controller.isProcessing(item.id!, \\'accept\\') ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.check_circle_outline_rounded, size: 20),\\n                      label: Text(\\n                        controller.isProcessing(item.id!, \\'accept\\') ? (getTranslated(\\'processing\\', context) ?? \\'Chargement...\\') : (getTranslated(\\'accept_reduction\\', context) ?? \\'Accepter\\'),\\n                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),\\n                      ),')

ui = ui.replace('controller.isLoading\\n                                  ? null\\n                                  : () => _showCounterOfferBottomSheet(\\n                                        context,\\n                                        controller,\\n                                        item,\\n                                      ),', 'controller.isAnyProcessing(item.id!) ? null : () => _showCounterOfferBottomSheet(context, controller, item),')

ui = ui.replace('icon: const Icon(Icons.swap_horiz_rounded, size: 20),\\n                              label: Text(\\n                                getTranslated(\\'make_counter_offer\\', context) ?? \\'Contre-offre\\',\\n                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),\\n                              ),', 'icon: controller.isProcessing(item.id!, \\'counter\\') ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.swap_horiz_rounded, size: 20),\\n                              label: Text(\\n                                controller.isProcessing(item.id!, \\'counter\\') ? (getTranslated(\\'processing\\', context) ?? \\'Chargement...\\') : (getTranslated(\\'make_counter_offer\\', context) ?? \\'Contre-offre\\'),\\n                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),\\n                              ),')

ui = ui.replace('controller.isLoading\\n                                ? null\\n                                : () => controller.refuseReduction(item.id!, context, orderId: item.orderId),', 'controller.isAnyProcessing(item.id!) ? null : () => controller.refuseReduction(item.id!, context, orderId: item.orderId),')

ui = ui.replace('icon: const Icon(Icons.close_rounded, size: 18),\\n                            label: Text(\\n                              getTranslated(\\'refuse_reduction\\', context) ?? \\'Refuser\\',\\n                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),\\n                            ),', 'icon: controller.isProcessing(item.id!, \\'refuse\\') ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Color(0xFFC62828), strokeWidth: 2)) : const Icon(Icons.close_rounded, size: 18),\\n                            label: Text(\\n                              controller.isProcessing(item.id!, \\'refuse\\') ? (getTranslated(\\'processing\\', context) ?? \\'Chargement...\\') : (getTranslated(\\'refuse_reduction\\', context) ?? \\'Refuser\\'),\\n                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 1),\\n                            ),')

# Also fix the CounterOffer bottom sheet button
ui = ui.replace('controller.isLoading ? null : () {', 'controller.isProcessing(item.id!, \\'counter\\') ? null : () {')
ui = ui.replace('child: Text(\\n                            controller.isLoading\\n                                ? (getTranslated(\\'processing\\', context) ?? \\'En cours...\\')\\n                                : (getTranslated(\\'send_counter_offer\\', context) ?? \\'Envoyer la proposition\\'),', 'child: controller.isProcessing(item.id!, \\'counter\\') ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text(\\n                            (getTranslated(\\'send_counter_offer\\', context) ?? \\'Envoyer la proposition\\'),')

with open('lib/features/vendor/negotiation/screens/vendor_negotiations_screen.dart', 'w', encoding='utf-8') as f:
    f.write(ui)
