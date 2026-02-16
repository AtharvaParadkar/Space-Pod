import 'dart:convert';

class ChatMessageModel {
  final List<ChatPartModel> parts;
  final String role;

  ChatMessageModel({required this.parts, required this.role});

  Map<String, dynamic> toMap() {
    return {'parts': parts.map((x) => x.toMap()).toList(), 'role': role};
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      parts: List<ChatPartModel>.from(
        map['parts']?.map((x) => ChatPartModel.fromMap(x)),
      ),
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) =>
      ChatMessageModel.fromMap(json.decode(source));
}

class ChatPartModel {
  final String text;

  ChatPartModel({required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text};
  }

  factory ChatPartModel.fromMap(Map<String, dynamic> map) {
    return ChatPartModel(text: map['text'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ChatPartModel.fromJson(String source) =>
      ChatPartModel.fromMap(json.decode(source));
}
