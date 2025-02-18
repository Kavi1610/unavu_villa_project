import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  BaseProvider() {
    // .........................Development Environment.........................
    httpClient.baseUrl = 'http://13.127.194.79/api/v1/';
    // ..........................Production Environment..........................
    // httpClient.baseUrl = "http://15.207.49.22:8080";
    httpClient.timeout = const Duration(seconds: 15);
  }
}
