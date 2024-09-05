# dio_curl_logger

`CurlLoggingInterceptor` is a Dio interceptor for logging HTTP requests and responses in a curl format, making it easier to debug and analyze network interactions in your applications.

## Features

- Logs HTTP requests in curl format for easy debugging.
- Pretty-prints JSON response data.
- Configurable logging for requests and responses.

## Installation

Add `curl_logging_interceptor` to your `pubspec.yaml` file:

```yaml
dependencies:
  dio_curl_logger: ^1.0.0
```

## Usage

### Importing the Package

To use `CurlLoggingInterceptor`, import the necessary packages in your Dart or Flutter project:

```dart
import 'package:dio/dio.dart';
import 'package:dio_curl_logger/dio_curl_logger.dart';
```

```
final dio = Dio();

dio.interceptors.add(
    CurlLoggingInterceptor(
      showRequestLog: true, // Set to false to disable logging of HTTP requests
      showResponseLog: true, // Set to false to disable logging of HTTP responses
   ),
);
```

## Example

#### Request Logging

When making an HTTP request, the interceptor will log the request in a curl format. Here’s an example with mock data:

```text
Request log:
curl  -X GET  https://api.example.com/resource?param1=value1&param2=value2
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer mock_token' \

Response Log:
URL: https://api.example.com/v1/resource?param1=value1&param2=value2
Headers:
 content-type: application/json
 date: Fri, 01 Jan 2024 12:00:00 GMT
 transfer-encoding: chunked
 server: MockServer/1.0

Response Data:
{
    {
        "name": "John Doe",
        "id": "123456",
        "description": "Sample item description",
        "creationDate": "2024-01-01",
        "status": "active"
    }
}
====================================
