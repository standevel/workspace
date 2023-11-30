import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../model/message.dart';
import '../model/user.dart';
import 'user_avatar.dart';

class MessageItem extends StatefulWidget {
  final Message message;
  const MessageItem({super.key, required this.message});

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  var isHovered = false;
  @override
  Widget build(BuildContext context) {
    var message = widget.message;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Card(
        elevation: 0.1,
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAvatar(user: widget.message.sender),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildMessageHeader(
                      message.sender, widget.message.createdAt!),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: SelectableText(
                      widget.message.content,
                      // softWrap: true,
                      style: textStyle(),
                    ),
                  ),
                  if (widget.message.files!.isNotEmpty)
                    _buildFilePreview(message.files!),
                  const SizedBox(height: 8.0),
                  if (widget.message.reactions != null)
                    _buildReactions(message.reactions!),
                ],
              ),
              //  Add PopupMenuButton for context menu
              if (isHovered) _buildContextMenu(message),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContextMenu(Message message) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (value) {
        //Handle menu item selection
        switch (value) {
          case 'add_reaction':
            //Handle adding reaction
            break;
          case 'copy':
            //Handle copy
            break;
          case 'reply':
            //Handle reply
            break;
          case 'delete':
            //Handle delete
            break;
          case 'pin':
            //Handle pin
            break;
          case 'unpin':
            //Handle unpin
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'add_reaction',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  color: Colors.red,
                  onPressed: () => {},
                  icon: const Text(
                    '❤️',
                    style: TextStyle(color: Colors.red, fontSize: 20.0),
                  )),
              IconButton(
                  color: Colors.amber,
                  onPressed: () => {},
                  icon: const Text(
                    '👍',
                    style: TextStyle(color: Colors.amber, fontSize: 20.0),
                  )),
              IconButton(
                  color: Colors.black,
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.emoji_emotions_sharp,
                    color: Colors.amber,
                  )),
              IconButton(
                  color: Colors.black,
                  onPressed: () => {},
                  icon: const Icon(Icons.add))
            ],
          ),
        ),
        const PopupMenuItem<String>(
          textStyle: TextStyle(color: Colors.black),
          value: 'copy',
          child: Row(
            children: [
              Icon(
                Icons.copy_sharp,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('Copy'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          textStyle: TextStyle(color: Colors.black),
          value: 'reply',
          child: Row(
            children: [
              Icon(
                Icons.reply_sharp,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('Reply'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          textStyle: TextStyle(color: Colors.black),
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_sharp,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('Delete'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          textStyle: TextStyle(color: Colors.black),
          value: 'pin',
          child: Row(
            children: [
              Icon(
                Icons.push_pin_sharp,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('Pin'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          textStyle: TextStyle(color: Colors.black),
          value: 'unpin',
          child: Row(
            children: [
              Icon(
                Icons.forward_sharp,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text('Forward'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageHeader(User sender, DateTime timestamp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          sender.firstName,
          style: textStyle(),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          _formatTimestamp(timestamp),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFilePreview(List<MessageFile> files) {
    //Implement logic to display file preview based on file type
    return Container(
      child: const Text('File Preview'),
    );
  }

  Widget _buildReactions(List<MessageReaction> reactions) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: reactions.map((reaction) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            reaction.reaction,
            //  style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat.jm().format(timestamp);
  }
}

TextStyle textStyle() {
  return const TextStyle(color: Colors.black);
}
