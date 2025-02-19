import 'package:altair/altair.dart';

import '../common/api.dart';

class TokenMock extends Token {
  @override
  int get id => 0;

  @override
  Map<String, dynamic> toJson() => {};
}

class AuthMock extends AuthRepository {
  @override
  Api get api => Api.instance;

  @override
  Map<String, String> dataToAuth(LoginModel model) => {
        'email': model.identifier,
        'password': model.password,
      };

  @override
  void callbackLogin(Token authModel) {}

  static Token fromJson(Map<String, dynamic> map) {
    return null;
  }

  @override
  AuthConfig get config => AuthConfig(
        authEndpoint: () => '/usuarios/login',
        fromJson: fromJson,
      );

  @override
  Future<RepositoryResponse<Token>> login(LoginModel model) async {
    await Future.delayed(Duration(seconds: 2));
    return RepositoryResponse.successOnline(data: TokenMock());
  }
}
