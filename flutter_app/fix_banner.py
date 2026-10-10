import os

file_path = 'lib/features/customer/home/widgets/redesign/banner_slider_widget.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

old_logic = """        // Collapse entirely (no residual gap) when banners are empty or null.
        if (activeBanners == null || activeBanners.isEmpty) {
          return const SizedBox.shrink();
        }"""

new_logic = """        // Shimmer pendant le chargement
        if (activeBanners == null) {
          return const BannerShimmer();
        }
        
        // Cacher si vide ou erreur
        if (activeBanners.isEmpty) {
          return const SizedBox.shrink();
        }"""

content = content.replace(old_logic, new_logic)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Banner logic fixed!")
