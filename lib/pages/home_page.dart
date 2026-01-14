import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_pod/bloc/chat_bloc.dart';
import 'package:space_pod/models/chat_message_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController chatController = .new();
    ChatBloc chatBloc = .new();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        // listenWhen: (previous,current)()=>,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              {
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Container(
                  height: .maxFinite,
                  width: .maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/space_bg.png'),
                      fit: .cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: .symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: .end,
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              "Space Pod",
                              style: TextStyle(fontSize: 24, fontWeight: .bold),
                            ),
                            Padding(
                              padding: const .only(bottom: 5),
                              child: Icon(
                                Icons.image_search,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const .all(16),
                              margin: const .all(3),
                              decoration: BoxDecoration(
                                borderRadius: .circular(16),
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                              child: Text(messages[index].parts.first.text),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 120,
                        padding: .symmetric(vertical: 30, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: chatController,
                                style: TextStyle(color: Colors.black),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                if (chatController.text.isNotEmpty) {
                                  chatBloc.add(
                                    GenerateNewChatTextMessageEvent(
                                      chatTextMsg: chatController.text,
                                    ),
                                  );
                                  chatController.clear();
                                }
                              },
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
