export 'validators.dart';
import 'package:vega/vega.dart';

import 'validators.dart';

class GroupValidator {
  final List<TextValidator> validators;

  const GroupValidator({
    this.validators = const [],
  });

  factory GroupValidator.single(TextValidator validator) => GroupValidator(
        validators: [validator],
      );

  static const GroupValidator email = GroupValidator(
    validators: [TextValidator.requiredText, TextValidator.email],
  );

  static const GroupValidator cnpj = GroupValidator(
    validators: [TextValidator.requiredText, TextValidator.cnpj],
  );

  static const GroupValidator cpf = GroupValidator(
    validators: [TextValidator.requiredText, TextValidator.cpf],
  );

  static const GroupValidator required = GroupValidator(
    validators: [TextValidator.requiredText],
  );

  static const GroupValidator phoneWithDDD = GroupValidator(
    validators: [TextValidator.requiredText, TextValidator.phoneWithDDD],
  );

  String validate(String string) => this
      .validators
      .firstWhere(
        (validator) => !validator?.validator(string),
        orElse: () => null,
      )
      ?.message;
}
