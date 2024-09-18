import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CurlLoggingInterceptor extends Interceptor {
  final bool _showRequestLog;
  final bool _showResponseLog;

  CurlLoggingInterceptor(
      {bool showRequestLog = true, bool showResponseLog = true})
      : _showRequestLog = showRequestLog,
        _showResponseLog = showResponseLog;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_showRequestLog) {
      _logRequestAsCurl(options);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_showResponseLog) {
      _logResponse(response);
    }
    handler.next(response);
  }

  void _logRequestAsCurl(RequestOptions options) {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('Request log:');

    buffer.write(
        'curl'); // Start the curl command with a line break for better readability

    // Add method
    buffer.write('  -X ${options.method}');

    // Add URI
    buffer.writeln('  ${options.uri.toString()}');

    // Add headers
    options.headers.forEach((key, value) {
      buffer.writeln('  -H \'$key: $value\' \\');
    });

    // Add data (POST/PUT)
    if (options.data != null) {
      final jsonData = const JsonEncoder.withIndent('  ')
          .convert(options.data); // Pretty-print JSON data
      buffer.writeln('  --data \'$jsonData\' \\');
    }

    // Log the final result
    log(buffer.toString());
  }

  void _logResponse(Response response) {
    const JsonEncoder encoder = JsonEncoder.withIndent('    ');
    String prettyJson;

    // Pretty-print response data if it's JSON (Map or List)
    if (response.data is Map || response.data is List) {
      prettyJson = encoder.convert(response.data);
    } else {
      prettyJson = response.data.toString();
    }

    // Use StringBuffer for more efficient string concatenation
    final buffer = StringBuffer();

    // Start building the log
    buffer.writeln('Response Log:');

    // Add URL
    buffer.write('URL: ');
    buffer.write('${response.requestOptions.uri}');
    buffer.writeln();

    // Add URL
    buffer.write('Status code: ');
    buffer.write('${response.statusCode}');
    buffer.writeln();

    // Add Headers
    buffer.writeln('Headers:');
    response.headers.forEach((key, values) {
      buffer.writeln(' $key: ${values.join(", ")}');
    });
    buffer.writeln();

    // Add Response Data
    buffer.writeln('Response Data:');
    buffer.writeln(prettyJson);
    buffer.writeln('====================================');

    // Log the final result
    log(buffer.toString());
  }
}
