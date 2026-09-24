
import json

paths = {
    "assets/language/en.json": {
        "nni": "National Identification Number (NNI)",
        "delivery_quarter": "Delivery Quarter",
        "door_photo": "Door Photo",
        "cancel_order": "Cancel Order",
        "cancellation_fee_warning": "Warning: Cancellation fees may apply if the order is already being prepared or delivered."
    },
    "assets/language/fr.json": {
        "nni": "Numéro National d'Identification (NNI)",
        "delivery_quarter": "Quartier de livraison",
        "door_photo": "Photo de la porte",
        "cancel_order": "Annuler la commande",
        "cancellation_fee_warning": "Attention : Des frais d'annulation peuvent s'appliquer si la commande est déjà en cours de préparation ou de livraison."
    }
}

for path, updates in paths.items():
    with open(path, "r", encoding="utf-8-sig") as f:
        data = json.load(f)
    data.update(updates)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

