with open('lib/core/widgets/base/no_internet_screen_widget.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'child: Column(mainAxisAlignment: padding == null ? MainAxisAlignment.center  : MainAxisAlignment.start, children: [',
    'child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: padding == null ? MainAxisAlignment.center  : MainAxisAlignment.start, children: ['
)

content = content.replace(
    '        ]),\n      ),\n    );\n  }',
    '        ]),\n      )),\n    );\n  }'
)

with open('lib/core/widgets/base/no_internet_screen_widget.dart', 'w', encoding='utf-8') as f:
    f.write(content)
