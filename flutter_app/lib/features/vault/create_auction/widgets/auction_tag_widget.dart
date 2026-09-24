import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:multishop_tchad/core/constants/custom_themes.dart';
import 'package:multishop_tchad/core/constants/dimensions.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AuctionTagWidget extends StatefulWidget {
  final TextfieldTagsController? controller;
  final List<String> initialTags;
  final ValueChanged<List<String>>? onTagsChanged;
  final String? hintText;
  final List<String> textSeparators;

  const AuctionTagWidget({
    super.key,
    this.controller,
    this.initialTags = const [],
    this.onTagsChanged,
    this.hintText,
    this.textSeparators = const [' ', ','],
  });

  @override
  State<AuctionTagWidget> createState() => _AuctionTagWidgetState();
}

class _AuctionTagWidgetState extends State<AuctionTagWidget> {
  TextfieldTagsController? _internalController;
  List<String> _lastTags = const [];

  TextfieldTagsController get _controller => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextfieldTagsController();
    }
    _lastTags = List<String>.from(widget.initialTags);
  }

  @override
  void dispose() {
    // Only dispose the controller we created; never an externally-owned one.
    _internalController?.dispose();
    super.dispose();
  }

  void _notifyIfChanged(List<String> tags) {
    if (listEquals(_lastTags, tags)) return;
    _lastTags = List<String>.from(tags);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onTagsChanged?.call(_lastTags);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double distanceToField = MediaQuery.of(context).size.width;

    return TextFieldTags(
      textfieldTagsController: _controller,
      initialTags: widget.initialTags.isNotEmpty ? widget.initialTags : const [],
      textSeparators: widget.textSeparators,
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (_controller.getTags?.contains(tag) ?? false) {
          return getTranslated('you_already_entered_that', context) ?? 'You already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return (context, sc, tags, onTagDelete) {
          _notifyIfChanged(tags);
          return TextField(
          controller: tec,
          focusNode: fn,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(color: Theme.of(context).hintColor.withValues(alpha: 0.15), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
            ),
            helperText: '',
            helperStyle: TextStyle(color: Theme.of(context).primaryColor),
            hintText: tags.isNotEmpty ? '' : (widget.hintText ?? getTranslated('enter_tag', context) ?? 'Enter tag...'),
            hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            errorText: error,
            prefixIconConstraints: BoxConstraints(maxWidth: distanceToField * 0.74),
            prefixIcon: tags.isNotEmpty
                ? SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tags.map((String tag) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusExtraLarge)),
                            color: Theme.of(context).primaryColor,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: Dimensions.paddingSizeExtraSmall,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tag, style: const TextStyle(color: Colors.white)),
                              const SizedBox(width: 4.0),
                              InkWell(
                                splashColor: Colors.transparent,
                                child: const Icon(Icons.cancel, size: 14.0, color: Color.fromARGB(255, 233, 233, 233)),
                                onTap: () => onTagDelete(tag),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : null,
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          );
        };
      },
    );
  }
}



