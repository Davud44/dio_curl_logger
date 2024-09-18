import 'package:dio/dio.dart';
import 'package:dio_curl_logger/dio_curl_logger.dart';

void main() async {
  final dio = Dio();

  // Add the CurlLoggingInterceptor
  dio.interceptors.add(
    CurlLoggingInterceptor(
      showRequestLog: true,
      showResponseLog: true,
    ),
  );

  // Make a sample HTTP request
  try {
    final response = await dio.get('https://google.com');
  } on Exception {
    print("Error occured");
  }
}
