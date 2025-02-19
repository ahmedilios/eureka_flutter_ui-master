import 'package:altair/altair.dart';

import '../../../../resources/api.dart';
import '../model.dart';

class AddressRepository {
  Future<RepositoryResponse<Address>> findByZipCode({
    String zipCode,
  }) async {
    try {
      final response = await FreeApi.instance.get(
        'https://viacep.com.br/ws/$zipCode/json',
      );

      return RepositoryResponse.successOnline(
        data: Address.fromViaCep(response.data),
      );
    } catch (error) {
      return RepositoryResponse.failure(message: error?.toString());
    }
  }
}
