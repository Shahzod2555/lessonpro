import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiResponse {
  final bool success;
  final dynamic data;
  final int? statusCode;
  final String? errorMessage;
  
  ApiResponse({required this.success, this.statusCode, this.data, this.errorMessage});
}

Future<http.Response> response({
  required String? email,
  required String? phoneNumber,
  required String password
  }) async {
  return await http.post(
    Uri.http('192.168.0.111:6043', '/login'),
    body: jsonEncode({"email": email, "phone_number": phoneNumber, "password": password}),
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
  );
}


Future<ApiResponse> requestLogin({
  required String? email,
  required String? phoneNumber,
  required String password
  }) async {
  try {final http.Response resp = await response(email: email, phoneNumber: phoneNumber, password: password);

    if (resp.statusCode == 200) {
      return ApiResponse(statusCode: resp.statusCode, success: true, data: jsonDecode(resp.body));
    } else {
      return ApiResponse(
        statusCode: resp.statusCode,
        success: false,
        errorMessage: jsonDecode(resp.body)['error'] ?? 'Неизвестная ошибка',
      );
    }
  } catch (e) {
    return ApiResponse(success: false, errorMessage: 'Что-то пошло не так, попробуйте позже');
  }
}
