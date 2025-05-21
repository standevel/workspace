import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/widgets/chat_input_editor.dart';
import 'package:peersync/widgets/message.widget.dart';

import '../model/message.dart';
import '../providers/provider.dart';
import '../providers/socket_providers.dart';

class ChannelWidget extends HookConsumerWidget {
  ChannelWidget({super.key});
  late List<Message> messages;
  // = [
  //   Message(
  //     content: 'Hello, how are you?',
  //     receiver: User(
  //         id: '1',
  //         firstName: 'John',
  //         profileImageUrl: '',
  //         email: 'kingstanley.ks16@gmail.com',
  //         lastName: 'Nwaegwu'),
  //     sender: User(
  //         id: '2',
  //         firstName: 'Alice',
  //         profileImageUrl: '',
  //         email: 'kingstanley.ks16@gmail.com',
  //         lastName: 'Joshua'),
  //     channel: Channel(id: '1', name: 'General Channel'),
  //     createdAt: DateTime(2023, 10, 7, 19, 30),
  //     files: [],
  //     reactions: [
  //       MessageReaction(
  //           reaction: '👍',
  //           userId: '3',
  //           username: 'Bob',
  //           timestamp: DateTime(2023, 11, 17, 14, 30)),
  //       MessageReaction(
  //           reaction: '❤️',
  //           userId: '4',
  //           username: 'Eve',
  //           timestamp: DateTime(2023, 11, 7, 17, 30)),
  //     ],
  //     mentions: [],
  //     readBy: [],
  //     isPrivate: false,
  //   ),
  //   Message(
  //     content:
  //         'I\'m doing well, thanks!  Add more dummy messages as needed Add more dummyAdd more dummy messages as needed Add more dummyAdd more dummy messages as needed Add more dummyAdd more dummy messages as needed Add more dummyAdd more dummy messages as needed Add more dummy messages as needed',
  //     receiver: User(
  //         id: '2',
  //         firstName: 'Alice',
  //         profileImageUrl: '',
  //         lastName: 'Abraham',
  //         email: 'abe@gmail.com'),
  //     sender: User(
  //         id: '1',
  //         firstName: 'John',
  //         profileImageUrl: '',
  //         lastName: 'Musa',
  //         email: 'musajohn@gmail.com'),
  //     channel: Channel(id: '1', name: 'Test channel'),
  //     createdAt: DateTime.now(),
  //     files: [],
  //     reactions: [
  //       MessageReaction(
  //           reaction: '🙂',
  //           userId: '1',
  //           username: 'John',
  //           timestamp: DateTime(2023, 10, 9, 11, 14)),
  //     ],
  //     mentions: [],
  //     readBy: [],
  //     isPrivate: false,
  //   ),
  //    ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeChannel = ref.watch(activeChannelProvider);
    AsyncValue<List<Message>> messages = ref.watch(messagesProvider);

    if (activeChannel.name!.isEmpty) {
      return const Center(
        child: Text(
          'No channel selected yet. Select a channel to start',
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 60.0,
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    activeChannel.name!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (MediaQuery.sizeOf(context).width > 600)
                    Text(activeChannel.description!,
                        style: const TextStyle(color: Colors.black)),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          color: Colors.black,
                          onPressed: () => {print('files clicked')},
                          icon: const Icon(Icons.folder)),
                      Text(
                          '${activeChannel.members!.length.toString()} Members',
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: ChatMessage(
            messages: messages,
          )),
          Container(
            constraints:
                const BoxConstraints(maxHeight: 150.0, minHeight: 100.0),
            child: Row(
              children: [
                Expanded(
                    child: Card(
                        color: Colors.white,
                        elevation: 10.0,
                        child: ChatInputEditor(
                            activeChannel.name!, false, null, activeChannel))),
              ],
            ),
          )
        ],
      );
    }
  }

  void addMessageToPool(WidgetRef ref, Message message, String channelId) {
    if (message.channel?.id == channelId) {
      ref.read(activeChannelMessagesProvider.notifier).state = [
        ...messages,
        message
      ];
    }
    if (!ref.read(allMessagesProvider).contains(message)) {
      ref.read(allMessagesProvider.notifier).state = [
        ...ref.read(allMessagesProvider),
        message
      ];
    }
    print(
        'updated active channel message list: ${ref.read(activeChannelMessagesProvider).toList()}');
  }
}
