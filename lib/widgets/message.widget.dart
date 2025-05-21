import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/widgets/message_item.dart';

import '../model/message.dart';

class ChatMessage extends ConsumerWidget {
  final AsyncValue<List<Message>> messages;
  const ChatMessage({super.key, required this.messages});

  // bool isHovered = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var messageList = [
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
    // ];

    return messages.when(
        loading: () => const SizedBox(child: CircularProgressIndicator()),
        error: (error, stack) => Text('Error: $error'),
        data: (messageList) {
          return ListView.builder(
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              return MessageItem(
                message: messageList[index],
              );
            },
          );
        });
  }
}

TextStyle textStyle() {
  return const TextStyle(color: Colors.black);
}
