import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:space_pod/models/chat_message_model.dart';

import '../apiKey.dart';

class SpaceRepo {
  static Future<String> chatGenerationRepo(
    List<ChatMessageModel> prevMessages,
  ) async {
    try {
      Dio dio = .new(
        BaseOptions(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );
      final response = await dio.post(
        // "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-preview:streamGenerateContent?key=$apiKey",
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=$apiKey",
        data: {
          "contents": prevMessages
              .map((toElement) => toElement.toMap())
              .toList(),
        },
      );
      log('!!!!!!!!!!!! STATUS: ${response.statusCode}');
      log('!!!!!!!!!!!! DATA: ${response.data}');
      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        return response
            .data['candidates']
            .first['content']['parts']
            .first['text'];
      }
      throw Exception('Request failed with status ${response.statusCode}');
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        log('🚨 Rate limit exceeded. Slow down requests.');
      } else {
        log('❌ Dio error: ${e.response?.data}');
      }
      throw Exception('Network error');
    } catch (e) {
      log('❌ Unexpected error: $e');
      throw Exception('Unexpected error');
    }
  }
}
