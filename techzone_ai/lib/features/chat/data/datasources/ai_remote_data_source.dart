import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiRemoteDataSource {
  final GenerativeModel _model;

  AiRemoteDataSource()
      : _model = GenerativeModel(
          model: 'gemini-2.5-flash',
          apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
        );

  Future<String> generateAiResponse(String messageText) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY is missing or empty.');
    }

    try {
      final content = [Content.text(messageText)];
      final response = await _model.generateContent(content);
      
      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Received empty response from Gemini API.');
      }
      
      return response.text!;
    } on GenerativeAIException catch (e) {
      throw Exception('Gemini API Error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to generate AI response: $e');
    }
  }
}
