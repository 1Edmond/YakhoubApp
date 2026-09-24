
import datetime

date_str = datetime.datetime.now().strftime("%d/%m/%Y")
content = f"""

### [{date_str}] - Étape 6 : Localisation des nouveaux textes

**Fichier(s)** : `assets/language/en.json`, `assets/language/fr.json`, `assets/language/ar.json`
**Type** : NEW
**Description** : Ajout des clés de traduction pour les textes récemment ajoutés (NNI, champs Checkout Tchad, Annulation).
**Changement** : Ajout des clés `nni`, `delivery_quarter`, `door_photo`, `cancel_order`, `cancellation_fee_warning` en français, anglais et arabe.
"""

with open("../modification.md", "a", encoding="utf-8") as f:
    f.write(content)

