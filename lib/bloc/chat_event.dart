part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class GenerateNewChatTextMessageEvent extends ChatEvent{
  final String chatTextMsg;

  GenerateNewChatTextMessageEvent({required this.chatTextMsg});
}