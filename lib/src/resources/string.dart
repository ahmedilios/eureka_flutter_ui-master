import 'package:email_validator/email_validator.dart';
import 'package:cpfcnpj/cpfcnpj.dart';

class VegaStringResources {
  static final _mobileReg = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static final _numberOnlyReg = RegExp(r'[^\d]');

  static bool isNotEmpty(String input) => input?.isNotEmpty ?? false;

  static bool isEmailValid(String email) =>
      (email?.isEmpty ?? true) ? true : EmailValidator.validate(email);

  static bool isCPFValid(String cpf) =>
      (cpf?.isEmpty ?? true) ? true : CPF.isValid(cpf);

  static bool isCNPJValid(String cnpj) =>
      (cnpj?.isEmpty ?? true) ? true : CNPJ.isValid(cnpj);

  static bool isPhoneDDDValid(String phone) =>
      phone == null ? true : _mobileReg.hasMatch(phone);

  static String removePhoneMask(String phone) =>
      phone?.replaceAll(_numberOnlyReg, '');
}
