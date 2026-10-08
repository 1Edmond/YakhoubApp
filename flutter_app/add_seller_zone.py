import json

with open('assets/language/fr.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

data["seller_zone"] = "Espace Vendeur"

with open('assets/language/fr.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
