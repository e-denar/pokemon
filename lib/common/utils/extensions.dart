// + Dio
import 'package:dio/dio.dart';

extension DioExt on Dio {
  Future<R> graphQLRequest<R>(
      {required String document,
      String? operationName,
      Map<String, dynamic>? variables,
      required R Function(Map<String, dynamic>) decoder}) async {
    try {
      final Response<Map<String, dynamic>> response =
          await post<Map<String, dynamic>>(
        '/graphql/v1beta',
        data: <String, dynamic>{
          'query': document,
          'operationName': operationName,
          'variables': variables,
        },
      );

      // handle graphql errors
      if ((response.data?['errors'] as List<dynamic>?)?.isNotEmpty == true) {
        // TODO: properly handle base on type of error
        throw Exception();
      }

      // return graphql data
      return decoder(response.data!['data'] as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }
}
