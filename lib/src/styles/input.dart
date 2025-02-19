import 'package:flutter/material.dart';

/// Opções de estilo para entradas.
///
/// Define um conjunto de propriedades de estilização para campos de texto.
class VegaInputStyle {
  const VegaInputStyle({
    this.innerDecoration = const InputDecoration(),
    this.outerDecoration = const BoxDecoration(),
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.showCursor,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  final Decoration outerDecoration;
  final InputDecoration innerDecoration;
  final TextCapitalization textCapitalization;
  final TextStyle textStyle;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final bool showCursor;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets padding;
  final EdgeInsets margin;

  /// Mescla
  VegaInputStyle merge(
    VegaInputStyle newModel,
  ) =>
      VegaInputStyle(
        innerDecoration: mergeDecoration(
          innerDecoration,
          newModel.innerDecoration,
        ),
        // TODO: Tratar merge de decorações
        // outerDecoration: mergeDecoration(
        //   outerDecoration,
        //   newModel.outerDecoration,
        // ),
        textCapitalization: newModel?.textCapitalization ?? textCapitalization,
        textStyle: newModel?.textStyle ?? textStyle,
        strutStyle: newModel?.strutStyle ?? strutStyle,
        textDirection: newModel?.textDirection ?? textDirection,
        textAlign: newModel?.textAlign ?? textAlign,
        textAlignVertical: newModel?.textAlignVertical ?? textAlignVertical,
        showCursor: newModel?.showCursor ?? showCursor,
        cursorWidth: newModel?.cursorWidth ?? cursorWidth,
        cursorRadius: newModel?.cursorRadius ?? cursorRadius,
        cursorColor: newModel?.cursorColor ?? cursorColor,
        keyboardAppearance: newModel?.keyboardAppearance ?? keyboardAppearance,
        padding: newModel?.padding ?? padding,
      );

  VegaInputStyle rounded([
    double radius = 10.0,
    Color color = Colors.transparent,
    double width = 1.5,
  ]) =>
      VegaInputStyle(
        innerDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              width: width,
              color: color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              width: width,
              color: color,
            ),
          ),
        ),
      );

  static InputDecoration mergeDecoration(
    InputDecoration oldDecoration,
    InputDecoration newDecoration,
  ) =>
      oldDecoration.copyWith(
        icon: newDecoration?.icon,
        labelText: newDecoration?.labelText,
        labelStyle: newDecoration?.labelStyle,
        helperText: newDecoration?.helperText,
        helperStyle: newDecoration?.helperStyle,
        helperMaxLines: newDecoration?.helperMaxLines,
        hintText: newDecoration?.hintText,
        hintStyle: newDecoration?.hintStyle,
        hintMaxLines: newDecoration?.hintMaxLines,
        errorText: newDecoration?.errorText,
        errorStyle: newDecoration?.errorStyle,
        errorMaxLines: newDecoration?.errorMaxLines,
        floatingLabelBehavior: newDecoration?.floatingLabelBehavior,
        isDense: newDecoration?.isDense,
        contentPadding: newDecoration?.contentPadding,
        prefixIcon: newDecoration?.prefixIcon,
        prefix: newDecoration?.prefix,
        prefixText: newDecoration?.prefixText,
        prefixIconConstraints: newDecoration?.prefixIconConstraints,
        prefixStyle: newDecoration?.prefixStyle,
        suffixIcon: newDecoration?.suffixIcon,
        suffix: newDecoration?.suffix,
        suffixText: newDecoration?.suffixText,
        suffixStyle: newDecoration?.suffixStyle,
        suffixIconConstraints: newDecoration?.suffixIconConstraints,
        counter: newDecoration?.counter,
        counterText: newDecoration?.counterText,
        counterStyle: newDecoration?.counterStyle,
        filled: newDecoration?.filled,
        fillColor: newDecoration?.fillColor,
        focusColor: newDecoration?.focusColor,
        hoverColor: newDecoration?.hoverColor,
        errorBorder: newDecoration?.errorBorder,
        focusedBorder: newDecoration?.focusedBorder,
        focusedErrorBorder: newDecoration?.focusedErrorBorder,
        disabledBorder: newDecoration?.disabledBorder,
        enabledBorder: newDecoration?.enabledBorder,
        border: newDecoration?.border,
        enabled: newDecoration?.enabled,
        semanticCounterText: newDecoration?.semanticCounterText,
        alignLabelWithHint: newDecoration?.alignLabelWithHint,
      );
}
