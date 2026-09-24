
import json

path = "assets/language/ar.json"
with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)

data["nni"] = "الرقم الوطني للتعريف (NNI)"
data["delivery_quarter"] = "حي التوصيل"
data["door_photo"] = "صورة الباب"
data["cancel_order"] = "إلغاء الطلب"
data["cancellation_fee_warning"] = "تحذير: قد يتم تطبيق رسوم إلغاء إذا كان الطلب قيد التحضير أو التوصيل."

with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

