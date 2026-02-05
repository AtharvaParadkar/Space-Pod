import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:space_pod/models/chat_message_model.dart';
import 'package:space_pod/repos/chat_repo.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<GenerateNewChatTextMessageEvent>(generateNewChatTextMessageEvent);
  }

  List<ChatMessageModel> messages = [];

  FutureOr<void> generateNewChatTextMessageEvent(
    GenerateNewChatTextMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    messages.add(
      ChatMessageModel(parts: [ChatPartModel(text: event.chatTextMsg)]),
    );
    emit(ChatSuccessState(messages: messages));
    final generatedText = await SpaceRepo.chatGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(
        ChatMessageModel(parts: [ChatPartModel(text: generatedText)]),
      );
      emit(ChatSuccessState(messages: messages));
    }
  }
}
