import 'package:altair/altair.dart';
import 'package:dio/dio.dart';

class FreeApi extends SimpleApi {
  FreeApi._()
      : super(
          Dio(
            BaseOptions(
              baseUrl: '',
              connectTimeout: 10000,
              receiveTimeout: 5000,
              followRedirects: true,
            ),
          ),
        );

  static final FreeApi _instance = FreeApi._();

  static FreeApi get instance => _instance;
}
