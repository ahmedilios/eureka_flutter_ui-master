import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as foreign;
import 'package:vega/src/resources/string.dart';

import '../../validators/group.dart';

mixin GenericTextController on TextEditingController {
  /// Nó de foco para o campo que receber o controlador.
  FocusNode focusNode;

  /// Grupo de validadores para testar o conteúdo do campo.
  ///
  /// Necessário invocar a validação pelo [Form].
  GroupValidator groupValidator;

  /// Função de validação chamada pelo widget de campo de texto.
  ///
  /// Necessário invocar a validação pelo [Form].
  String validate(String string) => groupValidator?.validate(string);
}

/// Controlador de texto padrão da Vega.
///
/// Possui embutido um [FocusNode] para requisição do foco no campo de texto e
/// um [GroupValidator] que aplica uma lista de validadores no conteúdo ao
/// sofrer uma validação por algum [Form].
class TextController extends TextEditingController with GenericTextController {
  @override
  final focusNode = FocusNode();

  @override
  GroupValidator groupValidator;

  TextController({
    String text,
    this.groupValidator = const GroupValidator(),
  }) : super(text: text);

  /// Gera um controlador de texto cujo conteúdo é requerido para validação.
  factory TextController.required([String text]) => TextController(
        text: text,
        groupValidator: GroupValidator.required,
      );
}

/// Controlador de texto com máscara padrão da Vega.
///
/// Possui embutido um [FocusNode] para requisição do foco no campo de texto e
/// um [GroupValidator] que aplica uma lista de validadores no conteúdo ao
/// sofrer uma validação por algum [Form].
class MaskedTextController extends foreign.MaskedTextController
    with GenericTextController {
  @override
  final focusNode = FocusNode();

  @override
  GroupValidator groupValidator;

  String Function(String) removeMask;

  String get unmaskedString => removeMask?.call(text) ?? text;

  MaskedTextController({
    String text,
    String mask,
    Map<String, RegExp> translator,
    this.removeMask,
    this.groupValidator = const GroupValidator(),
  }) : super(
          mask: mask,
          text: text,
          translator: translator,
        );

  @override
  String validate(String text) =>
      groupValidator?.validate(removeMask?.call(text) ?? text);

  factory MaskedTextController.phoneWithDDD([String text]) =>
      MaskedTextController(
        text: text,
        groupValidator: GroupValidator.phoneWithDDD,
        mask: '(00) 00000-0000',
        removeMask: (text) => VegaStringResources.removePhoneMask(text),
      );
}
