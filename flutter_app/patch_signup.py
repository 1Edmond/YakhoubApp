with open('lib/features/auth/widgets/sign_up_widget.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'final TextEditingController _referController = TextEditingController();',
    'final TextEditingController _referController = TextEditingController();\n  final TextEditingController _nniController = TextEditingController();'
)

content = content.replace(
    'final FocusNode _referFocus = FocusNode();',
    'final FocusNode _referFocus = FocusNode();\n  final FocusNode _nniFocus = FocusNode();'
)

content = content.replace(
    '_referController.clear();',
    '_referController.clear();\n        _nniController.clear();'
)

content = content.replace(
    '''// NNI Field (Hidden)
                      Container(
                        margin: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall),
                        child: Visibility(
                          visible: false,
                          child: CustomTextFieldWidget(
                            hintText: "NNI",
                            labelText: "NNI",
                            focusNode: FocusNode(),
                            nextFocus: FocusNode(),
                            required: false,
                            capitalization: TextCapitalization.words,
                            prefixIcon: Images.user,
                          ),
                        ),
                      ),''',
    '''// NNI Field
                      Container(
                        margin: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall),
                        child: CustomTextFieldWidget(
                          hintText: "NNI",
                          labelText: "NNI",
                          focusNode: _nniFocus,
                          nextFocus: _emailFocus,
                          required: true,
                          controller: _nniController,
                          capitalization: TextCapitalization.words,
                          prefixIcon: Images.user,
                          validator: (value) => ValidateCheck.validateEmptyText(value, "NNI is required"),
                        ),
                      ),'''
)

# Replace nextFocus for last name
content = content.replace(
    'nextFocus: _emailFocus,\n                              required: true,\n                              capitalization: TextCapitalization.words,\n                              controller: _lastNameController,',
    'nextFocus: _nniFocus,\n                              required: true,\n                              capitalization: TextCapitalization.words,\n                              controller: _lastNameController,'
)

# And now we need to map _nniController.text to register model
content = content.replace(
    'register.phone = phone;',
    'register.phone = phone;\n                              register.nni = _nniController.text.trim();'
)


with open('lib/features/auth/widgets/sign_up_widget.dart', 'w', encoding='utf-8') as f:
    f.write(content)
