with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if '=> v_theme_controller.ThemeController' in line:
        lines[i] = '// ' + line
        lines[i-1] = '// ' + lines[i-1]
    elif '=> v_splash_controller.SplashController' in line:
        lines[i] = '// ' + line
        lines[i-1] = '// ' + lines[i-1]
    elif '=> v_localization_controller.LocalizationController' in line:
        lines[i] = '// ' + line
        lines[i+1] = '// ' + lines[i+1]
    elif '=> v_bottom_menu_controller.BottomMenuController' in line:
        lines[i] = '// ' + line
    elif '=> v_tutorial_controller.TutorialController' in line:
        lines[i] = '// ' + line

with open('lib/core/di/di_container.dart', 'w', encoding='utf-8') as f:
    f.writelines(lines)
