import 'package:flutter/material.dart';
import 'package:vega/src/styles/input.dart';
import 'package:vega/src/resources/controllers/text.dart';

class VegaTextField extends StatefulWidget {
  final String hint;
  final String label;
  final int maxLines;
  final int maxLength;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final FocusNode next;
  final GenericTextController controller;
  final Function(String) onSubmitted;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget verifiedIcon;
  final VegaInputStyle style;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;

  const VegaTextField({
    this.controller,
    this.maxLength,
    this.onChanged,
    this.onClear,
    this.next,
    this.onSubmitted,
    this.verifiedIcon,
    this.hint = '',
    this.label = '',
    this.maxLines = 1,
    this.enabled = true,
    this.autocorrect = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.style = const VegaInputStyle(),
  });

  @override
  _VegaTextFieldState createState() => _VegaTextFieldState();
}

class _VegaTextFieldState extends State<VegaTextField> {
  GenericTextController controller;
  bool showClearButton;

  void setShowClearButton() => setState(() {
        showClearButton = widget.onClear != null &&
            (controller.focusNode.hasFocus || controller.text.isNotEmpty);
      });

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextController();
    showClearButton = widget.onClear != null && controller.focusNode.hasFocus;
    controller.focusNode.addListener(setShowClearButton);
    controller.addListener(setShowClearButton);
  }

  void onClear() {
    controller.clear();
    widget.onClear?.call();
  }

  Widget get clearButton => IconButton(
        icon: Icon(Icons.cancel),
        onPressed: onClear,
      );

  @override
  Widget build(BuildContext context) => Container(
        padding: widget.style.padding,
        decoration: widget.style.outerDecoration,
        margin: widget.style.margin,
        child: TextFormField(
          key: widget.key,
          enabled: widget.enabled,
          onFieldSubmitted: widget.next == null
              ? null
              : (_) => FocusScope.of(context).requestFocus(widget.next),
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textCapitalization: widget.style.textCapitalization,
          textInputAction: widget.next == null
              ? widget.textInputAction
              : TextInputAction.next,
          autocorrect: widget.autocorrect,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          validator: (str) => controller.validate.call(str),
          controller: controller,
          focusNode: controller.focusNode,
          decoration: widget.style.innerDecoration?.copyWith(
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: showClearButton
                ? clearButton
                : widget.verifiedIcon != null &&
                        widget.keyboardType != TextInputType.visiblePassword &&
                        (widget.controller.validate
                                ?.call(widget.controller.text) ==
                            null)
                    ? widget.verifiedIcon
                    : null,
          ),
          textAlign: widget.style.textAlign,
          style: widget.style.textStyle,
          strutStyle: widget.style.strutStyle,
          textDirection: widget.style.textDirection,
          textAlignVertical: widget.style.textAlignVertical,
          showCursor: widget.style.showCursor,
          cursorWidth: widget.style.cursorWidth,
          cursorRadius: widget.style.cursorRadius,
          cursorColor: widget.style.cursorColor,
          keyboardAppearance: widget.style.keyboardAppearance,
        ),
      );
}
