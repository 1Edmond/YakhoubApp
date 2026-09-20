import re

with open('lib/core/helpers/route_helper.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('''        if (state.matchedLocation == initial && isLoggedIn) {
          return initial;
        }''',
'''        if (state.matchedLocation == initial && isLoggedIn) {
          return null; // Fixed redirect loop
        }''')

with open('lib/core/helpers/route_helper.dart', 'w', encoding='utf-8') as f:
    f.write(content)
