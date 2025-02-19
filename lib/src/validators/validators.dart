import 'package:vega/src/resources/date.dart';
import '../resources/string.dart';

/// Assinatura de uma função de validação de texto
typedef TextValidatorFunction = bool Function(String);

/// Validador de uma cadeia de caracteres.
///
/// Retorna uma [message] se a função [validator] for `false` para uma
/// determinada `string`.
///
/// Exemplo de uso:
/// ```
/// final emailValidator = TextValidator.email;
/// final customValidator = TextValidator.custom(
///   message: 'Not long enough! Try it a bit harder.',
///   validator: (text) => text.length > 20,
/// );
///
/// final string = 'What power would Hell have if those here imprisoned were
/// not able to dream of Heaven?';
///
/// if (!emailValidator.validator(string)) return emailValidator.message;
/// if (!customValidator.validator(string)) return customValidator.message;
/// ```
///
/// Fazer o teste no [validator] e retornar a [message] é cansativo e, por
/// isso, talvez você queria usar o [GroupValidator], que já possui uma
/// lógica para testar todos os validadores contidos.
class TextValidator {
  /// Mensagem retornada caso o teste do [validator] retorne `false`.
  final String message;

  /// Função que recebe uma `string` e determina sua validade.
  final TextValidatorFunction validator;

  const TextValidator({
    this.message,
    this.validator,
  });

  static const TextValidator email = TextValidator(
    message: 'E-mail inválido',
    validator: VegaStringResources.isEmailValid,
  );
  static const TextValidator requiredText = TextValidator(
    message: 'Campo obrigatório',
    validator: VegaStringResources.isNotEmpty,
  );
  static const TextValidator cpf = TextValidator(
    message: 'CPF inválido',
    validator: VegaStringResources.isCPFValid,
  );
  static const TextValidator cnpj = TextValidator(
    message: 'CNPJ inválido',
    validator: VegaStringResources.isCNPJValid,
  );
  static const TextValidator phoneWithDDD = TextValidator(
    message: 'Telefone (com DDD) inválido',
    validator: VegaStringResources.isPhoneDDDValid,
  );
  static const TextValidator cardExpiryDate = TextValidator(
    message: 'Data inválida',
    validator: VegaDateResources.parseExpiry,
  );

  static const TextValidator cardExpiryDateYearAbbreviated = TextValidator(
    message: 'Data inválida',
    validator: VegaDateResources.parseExpiryYearAbbreviated,
  );
}
