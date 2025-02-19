import 'package:dio/dio.dart';
import 'package:altair/altair.dart';

class Test {
  static String baseUrl = 'http://localhost:3000/';
  static int connectTimeout = 3000;
  static int receiveTimeout = 3000;
}

class Api extends SimpleApi {
  Api._()
      : super(
          Dio(
            BaseOptions(
              baseUrl: Test.baseUrl,
              connectTimeout: Test.connectTimeout,
              receiveTimeout: Test.receiveTimeout,
              followRedirects: true,
            ),
          ),
        );

  static final Api _instance = Api._();

  static Api get instance => _instance;
}
