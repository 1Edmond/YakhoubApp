import re

with open('assets/language/fr.json', 'r', encoding='utf-8') as f:
    text = f.read()

# Fix the invalid JSON I added
text = re.sub(r'\}\s*\"\s*seller_zone.*$', '}', text)

with open('assets/language/fr.json', 'w', encoding='utf-8') as f:
    f.write(text)
